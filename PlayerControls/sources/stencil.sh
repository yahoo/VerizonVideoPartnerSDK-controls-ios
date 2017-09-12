set -e

if ! which sourcery > /dev/null; then
    echo "error: Sourcery is missing. Make brew install sourcery."
    exit 1
fi

templates=$1
output=$2

sourcery --sources sources --templates "${templates}" --output "${output}" 