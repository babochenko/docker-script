script='
from alpine
cmd uname
'

expectedResult="Linux"
actualResult="$(echo "$script" | docker script)"

./__verify.sh "$expectedResult" "$actualResult"
