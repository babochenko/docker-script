#!/usr/bin/env bash

>/dev/null command -p lintian || apt install lintian

lintian --info ./build/dockerscript_1_all.deb
