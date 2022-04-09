#!/usr/bin/env bash

# replace solc_x.y.z with solc_x_y_z
get_bin() {
  < $1 jq -r '.builds[]
    | "solc_\(.version) = { version = \"\(.version)\"; path = \"\(.path)\";"
    | sub("solc_(?<x>[0-9]+).(?<y>[0-9]+).(?<z>[0-9]+)"; "solc_\(.x)_\(.y)_\(.z)")'
}

# the actual binary urls
linux_urls="$(< linux.json jq -r '.builds[] | "https://binaries.soliditylang.org/linux-amd64/\(.path)"')"