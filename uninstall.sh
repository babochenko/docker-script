#!/usr/bin/env bash
# vim:set noet sts=0 sw=4 ts=4:
plugin="$HOME/.docker/cli-plugins/docker-script"
if [[ -f "$plugin" ]]; then
	rm "$plugin"
	echo "removed $plugin"
else
	echo "no plugin to remove!"
fi
