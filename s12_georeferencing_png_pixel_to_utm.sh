#!/bin/bash

# Ruta a la imagen de entrada (imagen sin georreferenciar)
input_image="./outputS11_intensity.png"

# Coordenadas pixel de la esquina superior izquierda (x, y)
pixel_ul_x=0
pixel_ul_y=0

# Coordenadas pixel de la esquina inferior derecha (x, y)
pixel_lr_x=839  # Reemplaza con el valor en píxeles de la esquina inferior derecha
pixel_lr_y=-367  # Reemplaza con el valor en píxeles de la esquina inferior derecha

# Coordenadas UTM de la esquina superior izquierda (este, norte)
utm_ul_x=547008.69  # Reemplaza con el valor UTM este de la esquina superior izquierda
utm_ul_y=4801680.15  # Reemplaza con el valor UTM norte de la esquina superior izquierda

# Coordenadas UTM de la esquina inferior derecha (este, norte)
utm_lr_x=547092.59  # Reemplaza con el valor UTM este de la esquina inferior derecha
utm_lr_y=4801643.43  # Reemplaza con el valor UTM norte de la esquina inferior derecha

# Definir el sistema de referencia de destino (UTM Zone 10N en este ejemplo)
output_srs="EPSG:25829"

# Especificar el nombre del archivo de salida georreferenciado
output_image="./outputS12_imagen_intensity_georeferenciada.png"

# Utilizar gdal_translate para georreferenciar la imagen
gdal_translate -a_ullr $pixel_ul_x $pixel_ul_y $pixel_lr_x $pixel_lr_y -a_srs $output_srs -a_ullr $utm_ul_x $utm_ul_y $utm_lr_x $utm_lr_y $input_image $output_image

echo "Imagen georreferenciada creada en $output_image"
