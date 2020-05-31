#!/usr/bin/env bash

entry_dir="$(pwd)"
cleanup (){
    cd "$entry_dir"
}
trap cleanup EXIT

cd bin/
bzr builddeb -- -nc -us -uc
