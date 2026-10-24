#!/usr/bin/env sh

set -eu

case "${TRAVIS_OS_NAME:-}" in
  osx)
    command -v brew >/dev/null 2>&1 || {
      echo "Homebrew is required on macOS" >&2
      exit 1
    }

    brew update
    brew install gmp bdw-gc pcre glib cairo gtk+3 libev json-c jansson docbook

    # XQuartz is distributed as a cask; the old caskroom tap is no longer needed.
    brew install --cask xquartz
    export PKG_CONFIG_PATH="/opt/X11/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
    ;;
  linux)
    # Travis installs these through the apt addon in travis.yml.
    ;;
  *)
    echo "Unsupported TRAVIS_OS_NAME: ${TRAVIS_OS_NAME:-<unset>}" >&2
    exit 2
    ;;
esac
