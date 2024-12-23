import paramiko

# Configuración del servidor remoto
REMOTE_HOST = "dario.alminana.com.ar"            # Dirección IP o nombre del servidor
USERNAME = "chango"                              # Usuario SSH
PASSWORD = None                                  # Contraseña del usuario (opcional si usas clave privada)
SSH_KEY_PATH = "/home/a126086/.ssh/id_rsa"       # Ruta a clave privada, por ejemplo: "/home/user/.ssh/id_rsa"

def get_disk_space(host, user, password=None, key_path=None):
    """
    Conecta a un servidor remoto via SSH y recupera el espacio en disco.
    """
    try:
        print(f"Conectando al servidor {host}...")

        # Configuración de conexión SSH
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

        if key_path:
            # Conexión usando clave privada
            ssh.connect(hostname=host, username=user, key_filename=key_path)
        else:
            # Conexión usando contraseña
            ssh.connect(hostname=host, username=user, password=password)

        print("Conexión exitosa. Ejecutando comando 'df -h'...")
        stdin, stdout, stderr = ssh.exec_command("df -h")

        # Leer y mostrar la salida
        output = stdout.read().decode('utf-8')
        error = stderr.read().decode('utf-8')

        if error:
            print("Error al ejecutar el comando:", error)
        else:
            print("\nEspacio libre en disco:")
            print(output)

        # Cerrar la conexión SSH
        ssh.close()
        print("Conexión cerrada.")

    except Exception as e:
        print(f"Error al conectar al servidor: {e}")

def main():
    print("Iniciando recuperación de espacio en disco remoto...\n")
    get_disk_space(REMOTE_HOST, USERNAME, PASSWORD, SSH_KEY_PATH)

if __name__ == "__main__":
    main()