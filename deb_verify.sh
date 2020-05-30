#!/usr/bin/env bash

>/dev/null command -p lintian || {
    yes | apt update
    yes | apt-get install lintian
}

lintian --info "$(find ./build/ -name 'dockerscript*.deb')"
