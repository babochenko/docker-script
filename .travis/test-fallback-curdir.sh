cat << EOF > Dockerfile
from alpine
cmd uname
EOF

expectedResult="Linux"
actualResult="$(docker script)"

./__verify.sh "$expectedResult" "$actualResult"
