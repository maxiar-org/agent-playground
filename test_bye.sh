#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd) || exit 1
output=$(mktemp) || exit 1
trap 'rm -f -- "$output"' EXIT

if ! bash "$script_dir/bye.sh" > "$output"; then
  printf 'Error: bye.sh no terminó correctamente.\n' >&2
  exit 1
fi

if ! printf 'Chau desde la mini-PC\n' | cmp -s - "$output"; then
  printf 'Error: la salida de bye.sh no coincide con la despedida esperada.\n' >&2
  exit 1
fi

exit 0
