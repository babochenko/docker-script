mkdir testdir
cat << EOF > Dockerfile
from alpine
cmd uname
EOF

expectedResult="Linux"
actualResult="$(docker script Dockerfile)"

./__verify.sh "$expectedResult" "$actualResult"

