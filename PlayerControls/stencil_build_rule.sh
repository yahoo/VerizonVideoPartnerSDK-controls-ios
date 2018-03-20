set -e

if ! which sourcery > /dev/null; then
echo "error: Sourcery is missing. Make brew install sourcery."
exit 1
fi

sourcery \
	--sources "./sources" \
	--sources "./build_scripts/code_generation" \
	--templates "${INPUT_FILE_DIR}/${INPUT_FILE_NAME}" \
	--output "${DERIVED_SOURCES_DIR}/${INPUT_FILE_BASE}_${TARGET_NAME}.generated.swift"
