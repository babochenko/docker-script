expectedResult="$1"
actualResult="$2"

if [[ ! "$expectedResult" == "$actualResult" ]]; then
    echo "!!! ERROR !!!"
    echo "expected result: $expectedResult"
    echo "actual result: $actualResult"
    exit 1
fi

