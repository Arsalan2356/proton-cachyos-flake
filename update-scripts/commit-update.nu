#!/usr/bin/env -S nix shell nixpkgs#nushell --command nu

use update.nu

def commit_update []: nothing -> nothing {
  let latest = update generate_sources

  git add -A
  let commit = git commit -m $"auto-update: ($latest.prev_tag) -> ($latest.new_tag)" | complete

  if ($commit.exit_code == 1) {
    print $"Latest version is ($latest.prev_tag), no updates found"
  } else {
    print $"Performed update from ($latest.prev_tag) -> ($latest.new_tag)"
    print "Updating Flake lockfile"
    nix flake update --commit-lock-file
  }
}

commit_update
