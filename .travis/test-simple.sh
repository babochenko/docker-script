cat << EOF > Dockerfile
from alpine
cmd uname
EOF

expectedResult="Linux"
actualResult="$(docker script .)"

[[ "$expectedResult" == "$actualResult" ]]
expectedEqualsActual=$?
exit $expectedEqualsActual