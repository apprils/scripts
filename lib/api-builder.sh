
set -e

root="$(realpath ..)"
srcFolder="$(basename "$(realpath .)")"

assert_source_folder .
assert_root_folder ..

distDir="$(jq -r .distDir "$root/package.json")"
outfile="$distDir/$srcFolder.js"

# esbundler should run in root folder
(cd "$root"; esbundler "$srcFolder/api/_server.ts" --sourcemap=inline --outfile="$outfile")

echo "$outfile"

