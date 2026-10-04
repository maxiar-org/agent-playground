#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd) || exit 1
output=$(mktemp) || exit 1
trap 'rm -f -- "$output"' EXIT

if ! bash "$script_dir/hello.sh" > "$output"; then
  printf 'Error: hello.sh no terminó correctamente.\n' >&2
  exit 1
fi

if ! printf 'Hola desde AI Dev Team\n' | cmp -s - "$output"; then
  printf 'Error: la salida de hello.sh no coincide con el saludo esperado.\n' >&2
  exit 1
fi

exit 0
