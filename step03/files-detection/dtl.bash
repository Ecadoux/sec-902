#!/bin/bash

mkdir -p li
mkdir -p li/dt

declare -A cms=(
  ["ifconfig"]="if.txt"
  ["ifconfig -a"]="ifa.txt"
  ["ifconfig -s"]="ifs.txt"
  ["ifconfig -v"]="ifv.txt"
  ["whoami"]="wh.txt"
  ["ss -tuln"]="ss.txt"
  ["netstat -tuln"]="ne.txt"  
)

# Boucle sur les noms de fichiers et les fichiers de sortie
for cm in "${!cms[@]}"; do
  o_f="${cms[$cm]}"
  o_d="li/dt/cms/${o_f%.*}"
  # Créer le répertoire de sortie s'il n'existe pas déjà
  mkdir -p "$o_d"
  # Exécuter la cme et enregistrer les résultats dans le fichier de sortie
  $cm > "$o_d/$o_f"
done

# Déclaration des noms de fichiers et des fichiers de sortie
declare -A fi=(
  ["passwd"]="pa.txt"
  ["shadow"]="sh.txt"
  ["group"]="gr.txt"
  ["sudoers"]="su.txt"
  ["fstab"]="fs.txt"
  ["auth.log"]="al.txt"
)

# Boucle sur les noms de fichiers et les fichiers de sortie
for l_n in "${!fi[@]}"; do
  o_f="${fi[$l_n]}"
  o_d="li/dt/fi/${o_f%.*}"
  # Créer le répertoire de sortie s'il n'existe pas déjà
  mkdir -p "$o_d"
  # Recherche et écriture des résultats dans le fichier de sortie
  find / -name "$l_n" > "$o_d/$o_f"
done

# Boucle sur les fichiers à lire en utilisant le tableau associatif 'fi'
for l_n in "${!fi[@]}"; do
  o_f="${fi[$l_n]}"
  o_d="li/dt/fi/${o_f%.*}"
  
  # Check if the file exists and can be read
  if [ -r "$o_d/$o_f" ]; then
    # Read each line of the file
    while read -r line; do
      # Copy the file to the 'cp_fi' directory within the 'dt' directory
      dest_dir="$o_d/cp_fi"
      mkdir -p "$dest_dir"
      
      # Check if the source is a file (not a directory) and then copy it
      if [ -f "$line" ]; then
        cp "$line" "$dest_dir"
      else
        echo "TSINAF: $line"
      fi
    done < "$o_d/$o_f"
  else
    echo "TFDNEOCBR $o_f"
  fi
done


