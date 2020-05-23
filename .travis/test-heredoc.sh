expectedResult="Linux"
actualResult="$(docker script << EOF
from alpine
cmd uname
EOF
)"

[[ "$expectedResult" == "$actualResult" ]]
expectedEqualsActual=$?
exit $expectedEqualsActual
