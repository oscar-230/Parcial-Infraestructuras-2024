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

IMAGES_DIR="imagenes"

for INPUT_PNG in "${IMAGES_DIR}"/*.png; do
  if [[ -f "$INPUT_PNG" ]]; then
    BASENAME=$(basename "$INPUT_PNG" .png)
    TEMP_FILE="${IMAGES_DIR}/${BASENAME}.bin"

    python3 fromPNG2Bin.py "${INPUT_PNG}"

    # Verificar si se creó el archivo binario
    if [[ ! -f "${TEMP_FILE}" ]]; then
      echo "Error: El archivo binario ${TEMP_FILE} no fue creado."
      continue
    fi

    ./main "${TEMP_FILE}"

    # Verificar si se creó el archivo de salida
    if [[ ! -f "${TEMP_FILE}.new" ]]; then
      echo "Error: El archivo ${TEMP_FILE}.new no fue creado por el programa C."
      continue
    fi

    python3 fromBin2PNG.py "${TEMP_FILE}.new"
    mv "${TEMP_FILE}.new" "${IMAGES_DIR}/${BASENAME}.bin.PNG"
  fi
done
