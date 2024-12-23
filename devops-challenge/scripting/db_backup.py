import os
import subprocess
import boto3
from datetime import datetime

# Configuración de parámetros
DB_USER = "root"                       # Usuario de la base de datos
DB_PASSWORD = "password"               # Contraseña de la base de datos
DB_NAME = "mi_base"                    # Nombre de la base de datos
BACKUP_DIR = "/tmp/backups"            # Directorio local donde se guardará el respaldo
S3_BUCKET_NAME = "amz-dababase-nublox" # Nombre del bucket en S3

def create_backup():
    """Genera un respaldo de la base de datos usando mysqldump."""
    if not os.path.exists(BACKUP_DIR):
        os.makedirs(BACKUP_DIR)

    backup_file = os.path.join(
        BACKUP_DIR, f"{DB_NAME}_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}.sql"
    )
    
    print("Generando respaldo de la base de datos...")
    try:
        subprocess.run([
            "mysqldump",
            f"-u{DB_USER}",
            f"-p{DB_PASSWORD}",
            DB_NAME,
            f"--result-file={backup_file}"
        ], check=True)
        print(f"Respaldo generado correctamente: {backup_file}")
        return backup_file
    except subprocess.CalledProcessError as e:
        print(f"Error al generar el respaldo: {e}")
        return None
    
backup_file = create_backup()

s3 = boto3.resource('s3')
# Filename - Nombre del archivo que vamos a subir
# Bucket - Nombre del Bucket S3 donde vamos a subir el archivo
# Key - Es el nombre con el que se guarda el objeto en S3 
s3.meta.client.upload_file(Filename=backup_file, Bucket=S3_BUCKET_NAME, Key=backup_file)