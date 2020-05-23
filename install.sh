#!/usr/bin/env bash
# vim:set noet sts=0 sw=4 ts=4:
installation_dir="$HOME/.docker/cli-plugins"
if [[ ! -d "$installation_dir" ]]; then
	mkdir -p "$installation_dir"
	echo "created directory $installation_dir"
fi

plugin="docker-script"
cp "$plugin" "$installation_dir"
chmod +x "$installation_dir"/"$plugin"
echo "installed $plugin into $installation_dir"

