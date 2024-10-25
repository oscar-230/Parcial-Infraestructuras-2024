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
# Modificaciones por: cuaical.oscar@correounivalle.edu.co
# Fecha: 2024-10-2024

 # Llamamos al directorio donde se alamcena las 18 imagenes del conjunto de imagenes dado
 # La imagenes procesadas se guardaran en este mismo directorio
IMAGEN_DIR="imagenes" 


# Verificar si hay imágenes PNG en el directorio
if ls ${IMAGEN_DIR}/*.png 1> /dev/null 2>&1; then
    echo "Procesando imágenes del directorio: ${IMAGEN_DIR}"
else
    echo "No se encontraron imágenes PNG en el directorio ${IMAGEN_DIR}."
    exit 1
fi

# Iniciar el procesamiento de cada imagen PNG en el directorio
for INPUT_PNG in ${IMAGEN_DIR}/*.png; do
    # Obtener el nombre base de la imagen (sin la extensión .png)
    BASE_NAME=$(basename "${INPUT_PNG}" .png)
    # Definir la ruta para el archivo binario temporal
    TEMP_FILE="${IMAGEN_DIR}/${BASE_NAME}.bin"

    echo "Procesando imagen: ${INPUT_PNG}"

    # Convertir la imagen PNG a formato binario
    python3 fromPNG2Bin.py "${INPUT_PNG}"

    # Ejecutar el procesamiento del archivo binario con el programa en C
    ./main "${TEMP_FILE}"

    # Definir el nombre del archivo binario procesado
    PROCESSED_FILE="${TEMP_FILE}.new"

    # Convertir el archivo binario procesado de nuevo a formato PNG
    python3 fromBin2PNG.py "${PROCESSED_FILE}"

    echo "Imagen procesada: ${INPUT_PNG}"
done