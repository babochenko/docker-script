expectedResult="Linux"
actualResult="$(docker script << EOF
from alpine
cmd uname
EOF
)"

./__verify.sh "$expectedResult" "$actualResult"
