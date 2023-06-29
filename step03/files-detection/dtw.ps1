# Crée le répertoire de détection
mkdir windows
mkdir windows/detection

# Déclaration des commandes et des fichiers de sortie
$commands = @{
    "ipconfig" = "ipconfig.txt"
    "ipconfig /all" = "ipconfig-all.txt"
    "net user" = "net_user.txt"
    "whoami" = "whoami.txt"
}

# Boucle sur les commandes et les fichiers de sortie
foreach ($entry in $commands.GetEnumerator()) {
    $command = $entry.Name
    $output_file = $entry.Value
    $output_dir = "windows\detection\commands\$($output_file.Split('.')[0])"
    # Crée le répertoire de sortie s'il n'existe pas déjà
    mkdir $output_dir
    # Exécute la commande et enregistre les résultats dans le fichier de sortie
    Invoke-Expression $command | Set-Content "$output_dir\$output_file"
}

# Déclaration des noms de fichiers et des fichiers de sortie
$files = @{
    "SAM" = "SAM.txt"
    "SYSTEM" = "SYSTEM.txt"
    "SECURITY" = "SECURITY.txt"
    "SOFTWARE" = "SOFTWARE.txt"
    "DEFAULT" = "DEFAULT.txt"
    "Security.evtx" = "Security-evtx.txt"
}

# Boucle sur les noms de fichiers et les fichiers de sortie
foreach ($entry in $files.GetEnumerator()) {
    $file_name = $entry.Name
    $output_file = $entry.Value
    $output_dir = "windows\detection\files\$($output_file.Split('.')[0])"
    # Crée le répertoire de sortie s'il n'existe pas déjà
    New-Item -ItemType Directory -Force -Path $output_dir
    # Recherche et écriture des résultats dans le fichier de sortie
    Get-ChildItem -Path "C:\Windows\System32" -Recurse -Include $file_name -ErrorAction SilentlyContinue -Force |
    ForEach-Object { $_.FullName } |
    Set-Content "$output_dir/$output_file"
}

# Boucle sur les fichiers à lire en utilisant le tableau associatif 'files'
foreach ($entry in $files.GetEnumerator()) {
    $file_name = $entry.Name
    $output_file = $entry.Value
    $output_dir = "windows\detection\files\$($output_file.Split('.')[0])"
    # Vérifie si le fichier existe et peut être lu
    if (Test-Path "$output_dir\$output_file") {
        # Lire chaque ligne du fichier
        Get-Content "$output_dir\$output_file" | ForEach-Object {
            $line = $_
            # Copie le fichier vers le répertoire de détection
            $dest_dir = "$output_dir\copied_files"
            New-Item -ItemType Directory -Force -Path $dest_dir
            Copy-Item $line $dest_dir
        }
    } else {
        Write-Host "Le fichier $output_file n'existe pas ou ne peut pas être lu."
    }
}
