# Challenge X

## Objetivos

* Dockerizar una app
* Aprovisionar la infraestructura mediente IaC
* Crear un pipeline para la integracion y el despligue continuo
* Automatizacion de tareas

Para realizar estas tareas se utilizo la siguiente estructura de directorios
```
./
├─ 1_docker
│  └─ <your project>
├─ 2_terraform
│  └─ <your project>
├─ 3_.github
│  └─ <your project>
└─ 4_scripting
   └─ <your project>
```

1. Dockerizar
  - Dentro del directorio docker encontraremos los ficheros, dockerfile donde creamos la imagen de nuestra aplicacion dockerizada, utilizando multi-stage.
  - Luego tenemos el archivo docker-compose.yml con el que iniciamos nuestro contenedor y exponemos la app en el puerto 9200.

2. Terraform
  - Partiendo del archivo main.tf en el directorio raiz, hacemos el llamado a los diferentes modulos escritos(ec2, networking, security-group, template) con los que procedemos a crear nuestra VPC, Red publica, Internet gateway, tabla de rutas, security group y la instancia EC2.
  En el directorio template tenemos el script que ejecutamos en la instancia una ves iniciada y es el encargado de poner en funcionamiento nuestra aplicacion.

3. .github
  -  Dentro de este directorio encontramos el directorio workflows, definido por github para almacenar nuestros archivos de automatizacio. En el encontramos el archivo deploy.yaml.
  Este archivo es el encargado de realizar el despligue de nuestra app cada ves que se publique un cambio en nuestra rama master.


4. Scripting
  - Aqui encontramos 3 arhivos en el cual resolvemos tareas diarias de forma automatizada.
    - check_status.sh: Escrito en BASH, consulta el estado del servicio apache en un servidor remoto.
    - db_backup.py: Escrito en python y utilizando la libreria boto3, realizamos un mysqldump y subimos el archivo resultando a un bucket S3.
    - remote_df.py: Escrito en python y usando la liberia paramiko, hace una consulta del estado de los disco de un servidor remoto.



## Puntos de mejora en la infraestructura. 
* En caso de mantener la misma arquitectura, colocar un balanceador que atienda las peticiones y las redirija a un Target gruop al cual eventualmente si fuese nesario se le podrian sumar mas instancias.
* Rediseñar la infraestructura y usar ECR y ECS. Alojando las imagenes en el registry y luego deployarlas en ECS.
* OPCION usar duckerHUB como repositorio
* Usar un role para autenticacion no access keys.
* Github runners para evitar las conexiones ssh.