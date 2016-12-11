if is-executable brew ; then
  brew install nvm
else
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
fi

. "${DOTFILES_DIR}/system/.nvm"
nvm install 6

# Globally install with npm

packages=(
  diff-so-fancy
  http-server
  nodemon
  release-it
  spot
  svgo
  tldr
  underscore-cli
  vtop
)

npm install -g "${packages[@]}"
