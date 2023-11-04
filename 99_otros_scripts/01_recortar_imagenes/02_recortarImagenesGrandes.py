#este script permite dividir una imagen grande en muchos
#recortes pequeños (con tamaño a decidir, en este caso 2560 pix)
#para usarlos en etiquetados y entrenamientos






import cv2
import os

# Carga la imagen grande
imagen_grande = cv2.imread('imagenGrande.png')

# Tamaño de los recortes
tamanio_recorte = 2560

# Obtiene las dimensiones de la imagen grande
alto, ancho, _ = imagen_grande.shape

# Crea un directorio para guardar los recortes
if not os.path.exists('recortes'):
    os.makedirs('recortes')

# Inicializa un contador para el nombre de las imágenes recortadas
contador = 1

for x in range(0, ancho, tamanio_recorte):
    for y in range(0, alto, tamanio_recorte):
        # Calcula las coordenadas del recorte
        x1, y1 = x, y
        x2, y2 = x + tamanio_recorte, y + tamanio_recorte

        # Realiza el recorte
        recorte = imagen_grande[y1:y2, x1:x2]

        # Guarda el recorte como una nueva imagen
        nombre_imagen = f'recorte_{contador}.png'
        cv2.imwrite(os.path.join('recortes', nombre_imagen), recorte)

        # Incrementa el contador
        contador += 1

