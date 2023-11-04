#########################################################################
# s11_convert_tif_to_png.sh
# -------------------------------------------------------------------
# Date                 : Oct 2023
# Copyright            : © 2023 by darango
# Email                : davidfernandezarango at hotmail dot com
#########################################################################
#
# This program is free software; you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation; either version 2 of the License, or     
# (at your option) any later version.                                   
#                                                                       
# Este script permite convertir un raster en formato .tif en otro 
# con formato jpg, mucho más ligero y capaz de trabajarse en otros 
# softwares de detección de imágenes. El objetivo de este script es 
# poder generar imágenes en jpg para poder usarse en Roboflow o  
# cualquier otro software de etiquetado de imágenes para la posterior 
# detección de objetos mediante modelos como YOLO   
#                                                                       
#########################################################################



#!/bin/bash

# Nombre del archivo de entrada y salida
input_file="imagenGrande.tif"
output_file="imagenGrande.png"

# Utilizar gdal_translate para convertir a escala de grises
gdal_translate -of PNG -ot Byte -scale -co WORLDFILE=YES "$input_file" "$output_file"

echo "Transformación completa: $output_file es una imagen en escala de grises en formato PNG."
