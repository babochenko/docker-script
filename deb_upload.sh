#!/usr/bin/env bash

gpg_key=$1

ppa='ppa:babochenko/ppa'
changes="$(find ./build/ -name '*.changes')"

# sign .changes file with a GPG key
debsign -k "$gpg_key" "$changes"
# push .changes to Launchpad PPA
dput "$ppa" "$changes"
