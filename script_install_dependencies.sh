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

# Install or update the versions specified in .tool-versions
while read -r plugin version; do
  if ! asdf list $plugin | grep -q "$version"; then
    echo "Installing $plugin $version..."
    asdf install $plugin $version
  else
    echo "$plugin $version is already installed. Skipping."
  fi
done < .tool-versions

# Reshim to reflect any changes
asdf reshim

# bundler
asdf exec gem install bundler
asdf exec bundle install
