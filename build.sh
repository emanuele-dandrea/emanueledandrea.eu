#!/bin/sh

set -e

deploy() {
  cp -Rf ./src ./target
  sed -i '/^@import/d' ./target/main.css
  cd ./target/styles
  cat header.css blog.css reset.css footer.css ../main.css > ../output
  mv about.css ../
  mv post.css ../
  cd ../
  rm ./main.css && rm -r ./styles
  mv ./output ./main.css
  cd ../
  # https://github.com/tdewolff/minify
  minify --recursive --inplace target
  rsync --archive --delete --info=progress target/ server:/var/www/emanueledandrea.eu
}

case "$1" in
# convert) convert ;;
deploy) deploy ;;
serve)
  cd src
  xdg-open http://localhost:8000
  python -m http.server
  ;;
clean) rm -r target ;;
*) echo "Unknown subcommand '$1'" ;;
esac
