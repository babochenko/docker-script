cat << EOF > Dockerfile
from alpine
cmd uname
EOF

echo '>>> TEST'
docker build
echo '>>> TEST 2'
docker script .
echo '>>> END TEST'

expectedResult="Linux"
actualResult="$(docker script .)"

./__verify.sh "$expectedResult" "$actualResult"

