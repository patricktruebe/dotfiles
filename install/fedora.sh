# Install packages

sudo -v

apps=(
  bash-completion
  bats
  coreutils
  ffmpeg
  fasd
  git
  git-extras
  hub
  python3-httpie
  ImageMagick
  jq
  nodejs-grunt
  python3
  python
  pigz
  ShellCheck
  tree
)

sudo dnf install "${apps[@]}"
