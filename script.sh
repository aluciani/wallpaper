#!/bin/bash

# Répertoire source (vous pouvez le modifier)
SOURCE_DIR="./input"
# Répertoire de sortie (vous pouvez le modifier)
OUTPUT_DIR="./output"

# Crée le répertoire de sortie s'il n'existe pas
mkdir -p "$OUTPUT_DIR"

# Boucle sur tous les fichiers d'extension jpg, jpeg, png dans le répertoire source
for file in "$SOURCE_DIR"/*.{jpg,jpeg,png}; do
    # Vérifie si le fichier existe (évite l'erreur si aucun fichier correspondant)
    if [ -e "$file" ]; then
        # Récupère le nom de fichier sans l'extension
        filename=$(basename "$file")
        base="${filename%.*}"
        extension="${filename##*.}"

        # Définit le nom de sortie avec le suffixe
        output_file="$OUTPUT_DIR/${base}-1920x1080.$extension"

        # Commande de conversion ImageMagick
        convert "$file" \
            \( -size 1920x1080 xc:black \) \
            \( -clone 0 -resize x1080 \) \
            -delete 0 -gravity center -composite \
            "$output_file"

        echo "Image convertie : $output_file"
    fi
done
