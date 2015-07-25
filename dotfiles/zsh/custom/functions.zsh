function col {
  awk "{print \$$1}"
}
function skip {
  n=$(($1 + 1))
  cut -d' ' -f$n-
}
