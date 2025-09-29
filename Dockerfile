FROM python:3.12-slim

# Instalar dependencias del sistema necesarias para OpenCV
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    libboost-all-dev \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de la app
WORKDIR /app

# Instalar dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del proyecto
COPY . .

# Exponer puerto Railway
EXPOSE 8000

# Comando para iniciar Django (sin migraciones automáticas)
CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:$PORT"]
