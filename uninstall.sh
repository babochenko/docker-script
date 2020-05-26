#!/usr/bin/env bash
# vim:set noet sts=0 sw=4 ts=4:
plugin='/usr/lib/docker/cli-plugins/docker-script'
if [[ -f "$plugin" ]]; then
	sudo rm "$plugin" \
	    && echo "removed ${plugin}" \
	    || echo "can't remove ${plugin}!"
else
	echo "no plugin to remove!"
fi
