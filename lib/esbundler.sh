
# Accepts same arguments as esbuild, namely a list of input files and a list of options.

set -e

files=""
externalExclude=""

while [[ $1 == *.ts ]]; do
  files="$files $1"
  shift
done

while [[ $1 == --external-exclude:* ]]; do
  # xargs to trim spaces
  externalExclude="$(echo "${1#*:} $externalExclude" | xargs)"
  shift
done

# rely on given --external, if any
if [[ "$*" == --external:* ]]; then
  external=""
else

  # marking all dependencies as externals
  query="[.dependencies + .devDependencies]"

  # except excluded ones
  if [ -n "$externalExclude" ]; then
    query="$query | del(.[][\"${externalExclude// /\",\"}\"])"
  fi

  query="$query | .[] | keys | map(\"--external:\" + .) | join(\" \")"

  external="$(jq -r "$query" package.json)"

fi

esbuild $files $external \
  --bundle \
  --log-level=warning \
  --platform=node \
  --target=node20 \
  --loader:.tpl=text \
  --loader:.html=text \
  --loader:.png=binary \
  --loader:.jpg=binary \
  --loader:.jpeg=binary \
  --loader:.gif=binary \
  --loader:.ico=binary \
  $* \
;
# intentionally using $*
# DO NOT change to "$@"

