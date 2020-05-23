mkdir testdir
cat << EOF > testdir/Dockerfile
from alpine
cmd uname
EOF

expectedResult="Linux"
actualResult="$(docker script testdir/Dockerfile)"

./__verify.sh "$expectedResult" "$actualResult"

