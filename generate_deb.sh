#!/usr/bin/env bash

cleanup-before-build() {
    rm -rf ./build/*
}

cleanup-after-build() {
    rm -rf ./build/*/
}

trap cleanup-after-build EXIT

2>/dev/null command yq || yes | >/dev/null pip install yq

# parse config
config='./bin/DEBIAN/control'
package="$(yq -r .Package "$config")"
version="$(yq -r .Version "$config")"
architecture="$(yq -r .Architecture "$config")"

output_dir="./build"
[[ -d "$output_dir" ]] || mkdir "$output_dir"

package_name="${package}_${version}_${architecture}"
package_dir="${output_dir}/${package_name}"

cleanup-before-build

# prepare scripts
[[ -f './bin/DEBIAN/preinst' ]] && chmod +x './bin/DEBIAN/preinst' || echo 12

# copy package data to build directory
cp -r ./bin "$package_dir"

# create package
dpkg-deb --build "$package_dir"