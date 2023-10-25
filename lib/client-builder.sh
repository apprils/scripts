
node \
  --env-file=../.env \
  --enable-source-maps \
  $(which vite) $* build

