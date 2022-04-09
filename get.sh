
#!/usr/bin/env bash
# Linux Only

if [[ -z $1 ]]; then
	>&2 echo "Usage: $(basename "$0") [N.M|latest]"
	>&2 echo ""
	>&2 echo "To Install v0.7.2:"
	>&2 echo ""
	>&2 echo '  $' "$(basename "$0") 7.2"
	>&2 echo ""
	>&2 echo "To Install latest version:"
	>&2 echo ""
	>&2 echo '  $' "$(basename "$0") latest"
	>&2 echo ""
	>&2 echo "Versions Downloaded:"
	>&2 echo ""
	for name in solc-static-linux-v*
	do
		echo -n '  v'
		echo "$name" | cut -f 2 -d 'v'
	done
	exit 1
fi

if [[ $1 == "latest" ]]; then
	latest=$(curl -s 'https://github.com/ethereum/solidity/releases.atom' | grep ethereum/solidity/releases/tag/v0 | cut -f 2 -d 'v' | cut -f 1 -d '"' | cut -f 2- -d '.' | head -n 1)
	solc_ver="v0.$latest"
else
	solc_ver="v0.$1"
fi

solc_url="https://github.com/ethereum/solidity/releases/download/$solc_ver/solc-static-linux"
solc_bin="solc-static-linux-$solc_ver"

if [[ -f $solc_bin ]]; then
	>&2 echo "Note: $solc_bin file already exists!"
	exit 0
fi

echo "Downloading..."
echo "       From: $solc_url"
echo "         To: $solc_bin"

wget -q --show-progress --progress=bar -O "$solc_bin" "$solc_url"


chmod 755 "$solc_bin"
exit 0