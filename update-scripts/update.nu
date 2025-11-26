# to invoke generate_sources directly, enter nushell and run
# `use update.nu`
# `update generate_sources`

def get_nix_hash [url: string]: nothing -> string  {
  nix store prefetch-file --hash-type sha256 --json $url | from json | get hash
}

export def generate_sources []: nothing -> record {
    let url = $"https://api.github.com/repos/CachyOS/proton-cachyos/releases/latest"
    let data = http get $url
    let tag = $data | to json | jq -r '.name | split(" ") | .[1]'
    let prev_sources: record = open ./sources.json

    let x86_64_url = http get $data.assets_url | to json | jq -r '.[] | .browser_download_url | select(contains("x86_64_v3") and (contains("sha") | not))'




    let sources = {
       	version: $tag
    	x86_64-linux: {
    	  url:  $x86_64_url
          hash: (get_nix_hash $x86_64_url)
    	}
    }

    if $sources.version == $prev_sources.version {
    	return {
    	  prev_tag: $tag
    	  new_tag: $tag
    	}
    }

    echo $sources | save --force "sources.json"

    return {
        new_tag: $tag
        prev_tag: $prev_sources.version
    }
}
