check_install() {
  if ! command -v $1 &> /dev/null
  then
    echo "Installing $1..."
    brew install $1
  else
    echo "$1 is installed."
  fi
}

# brew
check_install asdf
check_install jq
check_install swiftlint
check_install swiftformat

# asdf dependencies
asdf plugin add ruby
asdf plugin update ruby
while read -r line; do asdf install $line; done < .tool-versions
asdf reshim

# bundler
asdf exec gem install bundler
asdf exec bundle install
