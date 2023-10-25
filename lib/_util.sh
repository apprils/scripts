#!/usr/bin/env bash

print_red() {
  echo -n -e "\033[91m$*\033[m"
}

print_green() {
  echo -n -e "\033[32m$*\033[m"
}

print_blue() {
  echo -n -e "\033[94m$*\033[m"
}

print_magenta() {
  echo -n -e "\033[35m$*\033[m"
}

print_error() {
  echo -e "\n\t$(print_red ERROR): $*"
}

assert_root_folder() {

  local file="$1/package.json"

  if [ ! -f "$file" ] || [ -z "$(jq -r '.distDir // empty' "$file")" ]; then
    print_error "Current path does not seem to contain an Appril project"
    exit 1
  fi

}

assert_source_folder() {

  local file="$1/vite.config.ts"

  if [ ! -f "$file" ]; then
    print_error "Provided path does not seem to contain an Appril source folder"
    exit 1
  fi

}

# gently borrowed from https://gist.github.com/rverst/1f0b97da3cbeb7d93f4986df6e8e5695
chsv_check_version() {
  if [[ $1 =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then
    echo "$1"
  else
    echo ""
  fi
}

