#!/usr/bin/env sh

set -eu

if [ "$#" -ne 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 VERSION" >&2
  exit 2
fi

ats_version=$1
ats_package="ats-lang-anairiats-${ats_version}"
archive="${ats_package}.tgz"
download_url="https://raw.githubusercontent.com/githwxi/ATS-Anairiats/master/${archive}"

if [ -n "${TMPDIR:-}" ]; then
  tmp_dir=$TMPDIR
else
  tmp_dir=/tmp
fi
archive_path="${tmp_dir%/}/${archive}"
trap 'rm -f "$archive_path"' EXIT HUP INT TERM

if command -v curl >/dev/null 2>&1; then
  curl --fail --location --retry 3 --output "$archive_path" "$download_url"
elif command -v wget >/dev/null 2>&1; then
  wget --quiet --tries=3 --output-document="$archive_path" "$download_url"
else
  echo "Neither curl nor wget is installed" >&2
  exit 1
fi

tar -xzf "$archive_path" -C "${HOME:?HOME must be set}"

if [ ! -d "${HOME}/${ats_package}" ]; then
  echo "Expected extracted directory not found: ${HOME}/${ats_package}" >&2
  exit 1
fi
