function m4a {
  local url="$1"
  
  if [ -z "$url" ]; then
    echo "Usage: m4a <URL>"
    return 1
  fi
  
  echo "Checking available formats for: $url"
  
  # Get available formats and look for m4a audio formats
  local m4a_format=$(yt-dlp -F "$url" 2>/dev/null | grep -E "audio.*m4a" | grep -v "video" | tail -1 | awk '{print $1}')
  
  if [ -n "$m4a_format" ] && [ "$m4a_format" != "format" ]; then
    echo "Found native m4a format: $m4a_format"
    echo "Downloading with native m4a format..."
    yt-dlp --add-metadata -f "$m4a_format" "$url"
  else
    echo "No native m4a format found, using post-processing..."
    yt-dlp -x --audio-format m4a -f "bestaudio/best" --add-metadata "$url"
  fi
}