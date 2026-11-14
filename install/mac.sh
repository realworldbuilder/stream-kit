#!/bin/bash
# Stream Kit installer for Mac.
# Run in Terminal:  curl -fsSL https://raw.githubusercontent.com/realworldbuilder/stream-kit/main/install/mac.sh | bash
set -euo pipefail

echo
echo "Stream Kit"
echo "Installing Aitum Multistream (stream to Twitch + YouTube and stop each one on its own)."
echo

while pgrep -xq OBS; do
  echo "OBS is open. Close OBS, then press Enter."
  read -r < /dev/tty
done

url="https://github.com/Aitum/obs-aitum-multistream/releases/latest/download/aitum-multistream-macos-universal.pkg"
out="${TMPDIR:-/tmp}/aitum-multistream-macos-universal.pkg"
echo "Downloading the plugin..."
curl -fsSL -o "$out" "$url"

echo "Opening the plugin installer. Click through it (Continue, Install, type your Mac password, Close)."
open -W "$out"

echo
echo "Done. Opening the Stream Kit page for the next steps."
open "https://realworldbuilder.github.io/stream-kit/"
