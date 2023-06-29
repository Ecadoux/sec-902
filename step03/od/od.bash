#!/bin/bash

U=$( command -v uname)

case $( "${U}" | tr '[:upper:]' '[:lower:]') in
  l*)
    echo 'l'
    ;;
  d*)
    echo 'd'
    ;;
  m*|c*|mi*)
    echo 'w'
    ;;
  n*|wi*)
    echo 'w'
    ;;
  *)
    echo 'YOSINS'
    exit 1
    ;;
esac