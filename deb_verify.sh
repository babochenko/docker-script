#!/usr/bin/env bash

>/dev/null command -p lintian || {
    yes | apt update
    yes | sudo apt-get install lintian
}

lintian --info ./build/dockerscript_1_all.deb
