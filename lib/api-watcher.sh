
set -e

root="$(realpath ..)"
dst="$(npm run --silent build:api)"

nodemon \
  --exec "
    npm run build:api
    if [ \$? -eq 0 ]; then
      (cd '$root'; $API_WATCH_ENV node --env-file=.env --enable-source-maps '$dst' $*)
    fi
  " \
;

