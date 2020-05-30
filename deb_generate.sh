#!/usr/bin/env bash

cleanup-before-build() {
    rm -rf ./build/*
}

cleanup-after-build() {
    rm -rf ./build/*/
}

trap cleanup-after-build EXIT

# parse config
config='./bin/DEBIAN/control'
2>/dev/null command yq || {
    2>/dev/null command pip && {
        yes | >/dev/null pip install yq
        package="$(yq -r .Package "$config")"
        version="$(yq -r .Version "$config")"
        architecture="$(yq -r .Architecture "$config")"
    } || {
        package="$(cat "$config" | grep 'Package:' | awk '{print $2}')"
        version="$(cat "$config" | grep 'Version:' | awk '{print $2}')"
        architecture="$(cat "$config" | grep 'Architecture:' | awk '{print $2}')"
    }
}

output_dir="./build"
[[ -d "$output_dir" ]] || mkdir "$output_dir"

package_name="${package}_${version}_${architecture}"
package_dir="${output_dir}/${package_name}"

cleanup-before-build

# prepare scripts
[[ -f './bin/DEBIAN/preinst' ]] && chmod +x './bin/DEBIAN/preinst'

# copy package data to build directory
cp -r ./bin "$package_dir"

# post-copy
readme='./README.md'
[[ -f "${readme}" ]] && cp "${readme}" "${package_dir}/usr/share/doc/dockerscript/"

# generate changelog.gz
gzip -9 "${package_dir}/usr/share/doc/dockerscript/changelog"

# change owner and group of package to "root"
chown root -R "${package_dir}/usr"
chgrp root -R "${package_dir}/usr"

# create package
dpkg-deb --build "$package_dir"
