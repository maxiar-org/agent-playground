#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd) || exit 1
output=$(mktemp) || exit 1
trap 'rm -f -- "$output"' EXIT

if ! bash "$script_dir/wakeup.sh" > "$output"; then
  printf 'Error: wakeup.sh no terminó correctamente.\n' >&2
  exit 1
fi

if ! printf 'Buen día\n' | cmp -s - "$output"; then
  printf 'Error: la salida de wakeup.sh no coincide con el mensaje esperado.\n' >&2
  exit 1
fi

exit 0
