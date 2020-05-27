#!/usr/bin/env bash

>/dev/null command -p lintian || yes | sudo apt-get install lintian

lintian --info ./build/dockerscript_1_all.deb
