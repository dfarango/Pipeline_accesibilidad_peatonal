from PIL import Image

# Abre la imagen
image = Image.open('outputS11_intensity.png')  # Reemplaza 'entrada.png' con la ruta de tu imagen PNG

# Convierte la imagen a modo RGB si no lo está
image = image.convert('RGB')

# Extrae los canales de color R y G
r_band, g_band, b_band = image.split()

# Convierte los canales a listas de píxeles
r_pixels = list(r_band.getdata())
g_pixels = list(g_band.getdata())

# Realiza el cálculo para cada píxel
result_pixels = [(r - g) / (r + g + 1e-10) if (r + g + 1e-10) != 0 else 0 for r, g in zip(r_pixels, g_pixels)]

# Reclasifica la imagen a 0 o 1
result_image_data = [1 if pixel > 0 else 0 for pixel in result_pixels]

# Crea una nueva imagen con los resultados
result_image = Image.new('1', image.size)  # '1' para modo de imagen binaria (0 o 1)
result_image.putdata(result_image_data)

# Guarda la imagen resultante
result_image.save('outputS12_crosswalksSegmentation.png')

# Cierra la imagen original
image.close()
