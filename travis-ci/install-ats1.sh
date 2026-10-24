#!/usr/bin/env sh

set -eu

if [ "$#" -ne 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 VERSION" >&2
  exit 2
fi

ats_version=$1
ats_package="ats-lang-anairiats-${ats_version}"
archive="${ats_package}.tgz"
script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
archive_path="${script_dir}/../xassets/ATS1/${archive}"

if [ ! -f "$archive_path" ]; then
  echo "ATS1 archive not found: $archive_path" >&2
  exit 1
fi

tar -xzf "$archive_path" -C "${HOME:?HOME must be set}"

if [ ! -d "${HOME}/${ats_package}" ]; then
  echo "Expected extracted directory not found: ${HOME}/${ats_package}" >&2
  exit 1
fi
