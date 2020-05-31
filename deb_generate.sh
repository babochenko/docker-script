#!/usr/bin/env bash

entry_dir="$(pwd)"
cleanup (){
    cd "$entry_dir"
}
trap cleanup EXIT

cd bin/
bzr builddeb --result-dir=../build -- -nc -us -uc
