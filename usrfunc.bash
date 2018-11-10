# Go n up
up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
