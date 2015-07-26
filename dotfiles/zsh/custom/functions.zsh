function col {
  awk "{print \$$1}"
}

function skip {
  n=$(($1 + 1))
  cut -d' ' -f$n-
}

# process listening on port
function procport {
  service="4TCP"
  [[ -n "$1" ]] && service="${service}:$1"
  sudo lsof -n "-i${service}" | grep LISTEN
}

# file handles held by an open process
function procfile {
  lsof -p "$1" | col 9 | sort | uniq | while read -r file; do
    if test -f "${file}"; then
      echo "${file}"
    fi
  done
}

