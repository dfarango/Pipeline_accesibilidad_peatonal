# NOTA. Para ejecutar este script es necesario tener instalado previamente imageMagik
# url: https://imagemagick.org/index.php

#!/bin/bash


# Nombre del archivo de entrada y salida
input_file="outputS10_intensity.tif"
output_file="outputS11_intensity.png"

# Convertir a TIF con compresión LZW y tamaño 640x480
convert "$input_file"  -compress LZW "$output_file"

# Verificar y ajustar la profundidad de bits a 8 bits
convert "$output_file" -depth 16 "$output_file"

# Convertir a perfil de color sRGB
convert "$output_file" -profile /usr/share/color/icc/sRGB.icc "$output_file"

# Cambiar el tipo de archivo a JPEG
mv "$output_file" "$output_file"

echo "Transformación completa: $output_file.jpg es compatible con Roboflow."

