package main

import (
	"bytes"
	"fmt"
	"github.com/docker/cli/cli-plugins/manager"
	"github.com/docker/cli/cli-plugins/plugin"
	"github.com/docker/cli/cli/command"
	"github.com/docker/docker/api/types"
	"github.com/spf13/cobra"
	"io"
	"io/ioutil"
	"os"
	"path"
)

var metadata = manager.Metadata{
	SchemaVersion: "0.1.0",
	Vendor:        "dbabochenko",
	Version:       "0.1.0",
}

func createPluginCommand(cli command.Cli) *cobra.Command {
	return &cobra.Command{
		Use:     "script",
		Example: "script .",
		Args:    nil,
		Run: func(cmd *cobra.Command, args []string) {
			var dockerfile io.Reader
			var err error

			dockerfileDesc := args[0]

			dockerfile, err = tryReadStdin()
			if err != nil {
				return
			}
			if dockerfile == nil {
				dockerfile = openDockerfile(dockerfileDesc)
			}
			if dockerfile == nil {
				fmt.Fprintf(os.Stderr, "Could not find dockerfile: %s", dockerfileDesc)
				return
			}

			client := cli.Client()

			resp, err := client.ImageBuild(nil, dockerfile, types.ImageBuildOptions{})
			if err != nil {
				fmt.Fprintf(os.Stderr, "Could not build image: %s", err)
				return
			}

			var response []byte
			_, _ = resp.Body.Read(response)

			container := ""

			err = client.ContainerStart(nil, container, types.ContainerStartOptions{})
			if err != nil {
				fmt.Fprintf(os.Stderr, "Could not start container: %s", err)
				return
			}
		},
	}
}

func tryReadStdin() (io.Reader, error) {
	var input []byte

	byteCount, err := os.Stdin.Read(input)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%s", err)
		return nil, err
	}
	if byteCount == 0 {
		return nil, err
	}

	return bytes.NewReader(input), nil
}

func openDockerfile(inputFile string) io.Reader {
	file, _ := os.Stat(inputFile)

	var dockerfilePath string
	if file.Mode().IsDir() {
		dockerfilePath = path.Dir(inputFile) + "/Dockerfile"
	} else {
		dockerfilePath = inputFile
	}

	dockerfile, err := ioutil.ReadFile(dockerfilePath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Could not find dockerfile: %s", dockerfilePath)
		fmt.Fprintf(os.Stderr, "%s", err)
		return nil
	}

	return bytes.NewReader(dockerfile)
}

func main() {
	plugin.Run(createPluginCommand, metadata)
}
