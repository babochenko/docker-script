package main

import (
	"fmt"
	"github.com/docker/cli/cli-plugins/manager"
	"github.com/docker/cli/cli-plugins/plugin"
	"github.com/docker/cli/cli/command"
	"github.com/docker/docker/api/types"
	"github.com/spf13/cobra"
	"os"
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
			client := cli.Client()
			// result := args[0]

			resp, err := client.ImageBuild(nil, nil, types.ImageBuildOptions{})
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

func main() {
	plugin.Run(createPluginCommand, metadata)
}
