>/dev/null command -p lintian || {
    yes | apt update
    yes | apt-get install lintian
}

package="$(find ../build/ -name 'dockerscript*.deb')"
verification_result="$(lintian --info "$package")"

expected_result=""
./__verify.sh "$expected_result" "$verification_result"
