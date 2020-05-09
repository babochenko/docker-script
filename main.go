package main

import (
	"github.com/docker/cli/cli-plugins/manager"
	"github.com/docker/cli/cli-plugins/plugin"
	"github.com/docker/cli/cli/command"
	"github.com/spf13/cobra"
)

func main() {
	metadata := manager.Metadata{
		SchemaVersion: "0.1.0",
		Vendor:        "dbabochenko",
		Version:       "0.1.0",
	}

	cmd := func(cli command.Cli) *cobra.Command {
		command := cobra.Command{}

		return &command
	}

	plugin.Run(cmd, metadata)
}
