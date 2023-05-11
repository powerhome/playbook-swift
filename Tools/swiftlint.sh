export PATH="$PATH:/opt/homebrew/bin" #needed line for M1 Macs

if [ ! $CI ]; then
  if which swiftlint >/dev/null; then
    swiftlint --fix && swiftlint
  else
    echo "SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    exit 1
  fi
fi