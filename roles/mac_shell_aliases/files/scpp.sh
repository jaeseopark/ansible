# Generic scp push helper
# Requires scp_remote in environment (exported from template via role variable)
scpp() {
  local ext="$1"
  if [ -z "${ext}" ]; then
    echo "Usage: scpp <extension>"
    return 1
  fi

  if [ -z "${scp_remote}" ]; then
    echo "scp_remote variable is not set"
    return 1
  fi

  scp *.${ext} "${scp_remote}" && rm -- *.${ext}
}
