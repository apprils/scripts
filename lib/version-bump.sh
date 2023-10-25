
set -e

version="$1"

if [ -z "$version" ]; then
  print_magenta "\n  No version provided, exiting...\n"
  exit 0
fi

if [ -z "$(chsv_check_version "$version")" ]; then
  print_error "Invalid version provided"
  exit 1
fi

print_blue "\nThis will create a new branch: $version\n"
read -e -p "Continue? [ y/n ]: " -i "y" input

if [[ ! "$input" =~ "y" ]]; then
  exit 0
fi

git checkout -b "$version"

print_blue "\nUpdate package.json version?\n"
read -e -p "[ y/n ]: " -i "y" input

if [[ "$input" =~ "y" ]]; then
  echo "Updating package.json..."
  cat package.json \
    | jq --arg version "$version" '.version = $version' \
    | tee package.json > /dev/null
fi

print_blue "\nCommit message\n"
read -e -i "version bump: $version" input

if [ -n "$input" ]; then
  git commit -am "$input"
fi

