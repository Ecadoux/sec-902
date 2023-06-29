#!/bin/bash
mkdir -p mac
mkdir -p mac/mac/detection

declare -A c=(
  ["i"]="ifconfig.txt"
  ["a"]="ifconfig-a.txt"
  ["l"]="ifconfig-l.txt"
  ["w"]="whoami.txt"
)

for k in "${!c[@]}"; do
  f="${c[$k]}"
  o="mac/detection/c/$k/${f%.*}"
  mkdir -p "$o"
  $k"fconfig" > "$o/$f"
done

declare -A f=(
  ["p"]="passwd.txt"
  ["s"]="shadow.txt"
  ["g"]="group.txt"
  ["u"]="sudoers.txt"
  ["t"]="fstab.txt"
  ["y"]="system-log.txt"
)

for k in "${!f[@]}"; do
  o="${f[$k]}"
  d="mac/detection/f/$k/${o%.*}"
  mkdir -p "$d"
  find / -name "$k" 2>/dev/null > "$d/$o"
done

for k in "${!f[@]}"; do
  o="${f[$k]}"
  d="mac/detection/f/$k/${o%.*}"
  if [ -r "$d/$o" ]; then
    while read -r l; do
      dd="$d/c"
      mkdir -p "$dd"
      cp "$l" "$dd"
    done < "$d/$o"
  else
    echo "$o n'existe pas ou ne peut pas être lu."
  fi
done
