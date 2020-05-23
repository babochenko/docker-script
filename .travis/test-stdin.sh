script='
from alpine
cmd uname
'

expectedResult="Linux"
actualResult="$(echo "$script" | docker script)"

[[ "$expectedResult" == "$actualResult" ]]
expectedEqualsActual=$?
exit $expectedEqualsActual
