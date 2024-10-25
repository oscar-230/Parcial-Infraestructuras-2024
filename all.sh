#!/usr/bin/env bash
#
# Este script se encarga de invocar los tres programas que permiten la 
# conversion de un PNG a secuencia de pixeles, se procesan esos pixeles y
# posteriormente se convierte esa secuencia de pixeles a un archivo en formato
# PNG
#
# Autor: John Sanabria - john.sanabria@correounivalle.edu.co
# Fecha: 2024-08-22
#
IMAGEN_DIR="imagenes"  # Directorio donde están las imágenes

# Procesar cada imagen en el directorio
for INPUT_PNG in ${IMAGEN_DIR}/*.png; do
    # Extraer el nombre base del archivo sin la extensión .png
    BASE_NAME=$(basename "${INPUT_PNG}" .png)
    # Definir el archivo binario con la extensión .bin
    TEMP_FILE="${IMAGEN_DIR}/${BASE_NAME}.bin"

    echo "Procesando imagen: ${INPUT_PNG}"

    # Convertir la imagen PNG a binario
    python3 fromPNG2Bin.py "${INPUT_PNG}"

    # Procesar el archivo binario con el ejecutable
    ./main "${TEMP_FILE}"

    # Definir el nombre del archivo procesado
    PROCESSED_FILE="${TEMP_FILE}.new"

    # Convertir el archivo binario procesado a imagen PNG
    python3 fromBin2PNG.py "${PROCESSED_FILE}"

    echo "Imagen procesada: ${INPUT_PNG}"
done