expected_result=""
verification_result="$(./../deb_verify.sh)"
./__verify.sh "$expected_result" "$verification_result"
