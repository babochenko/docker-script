#!/usr/bin/env bash
package="$(find ./build/ -name '*.deb')"

>/dev/null command -p docker || {
    yes | apt-get install docker
}

if [[ ! -f "$package" ]]; then
    echo 'could not find package to install! exiting...'
    exit 1
fi

echo 'installing package...'
dpkg -i "$package" \
    && echo 'package installed!' \
    || { echo "can't install package! exiting..."; exit 1; }
