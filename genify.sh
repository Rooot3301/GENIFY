#!/bin/bash

# Répertoire de destination
output_dir="/home/romain/perso/doc"

# Vérifie si le répertoire de destination existe, sinon le crée
mkdir -p "$output_dir" || {
    echo "Erreur : Impossible de créer le répertoire de destination $output_dir."
    exit 1
}

# Demande à l'utilisateur le nombre de PDF à créer
read -p "Combien de fichiers PDF souhaitez-vous créer ? " num_pdf

# Vérifie si l'entrée est un nombre
if ! [[ "$num_pdf" =~ ^[0-9]+$ ]]; then
    echo "Veuillez entrer un nombre valide."
    exit 1
fi

# Demande à l'utilisateur la taille minimale des fichiers PDF (en Mo)
read -p "Quelle est la taille minimale des fichiers PDF que vous souhaitez (en Mo) ? " min_size_mb

# Vérifie si l'entrée est un nombre
if ! [[ "$min_size_mb" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Veuillez entrer un nombre valide."
    exit 1
fi

# Convertit la taille minimale en octets
min_size=$((min_size_mb * 1024 * 1024))

# Crée les PDF dans le répertoire de destination
cd "$output_dir" || {
    echo "Erreur : Impossible d'accéder au répertoire de destination $output_dir."
    exit 1
}
for ((i=1; i<=$num_pdf; i++)); do
    output_file="document_$i.pdf"
    # Génère un fichier avec des données répétitives jusqu'à ce qu'il atteigne la taille minimale
    head -c $min_size < /dev/zero > "$output_file" || {
        echo "Échec de la création du PDF $i."
        exit 1
    }
    echo "PDF $i créé : $output_file"
done

echo "Terminé."
