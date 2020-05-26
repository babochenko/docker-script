#!/usr/bin/env bash
package="$(find ./build/ -name '*.deb')"

if [[ ! -f "$package" ]]; then
    echo 'could not find package to install! exiting...'
    exit 1
fi

echo 'installing package...'
sudo dpkg -i "$package"
echo 'package installed!'
