# This file is not used in a playbook yet.

function m4a_n {
  yt-dlp -x --audio-format m4a -f "bestaudio/best" ${1}
}

function m4a {
  youtube-dl --add-metadata -f 140 ${1}
}
