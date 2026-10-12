#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd) || exit 1
output=$(mktemp) || exit 1
trap 'rm -f -- "$output"' EXIT

if ! bash "$script_dir/goodnight.sh" > "$output"; then
  printf 'Error: goodnight.sh no terminó correctamente.\n' >&2
  exit 1
fi

if ! printf 'Buenas noches\n' | cmp -s - "$output"; then
  printf 'Error: la salida de goodnight.sh no coincide con el saludo esperado.\n' >&2
  exit 1
fi

exit 0
