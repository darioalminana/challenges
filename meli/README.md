# Te enviamos este desafío para que investigues diferentes alternativas y nos presentes, a tu entender posibles implementaciones o soluciones.

Desarrollo
&nbsp;

Tools:
&nbsp;

``` https://hub.docker.com/_/python ```


* Objetivo:

``` Armar dentro de un docker o contenedor, una api en python, en la cual tenga un endpoint para saber el porcentaje de uso de un device en particular o de todos los devices que posee.
Agregar un endpoint que termine ejecutando cierto script interno que realice una acción. 
Dicho código, deberá presentarse a través de un repositorio de git. 
Que controles le pondrias para que sea segura?
```


## Infraestructura (Se puede elegir 1 de las 2 problemáticas, o si te animas las 2)

### Contexto:
Tenemos 10k de instancias en AWS corriendo MySql. Dentro de los mismos separamos en 2 LVM los archivos de DATA y los Binlogs. 

### Problemática 1:
De qué forma podríamos automatizar un proceso que analice cuanta capacidad hay utilizada en los File System de dichos Mysql y nos deje un reporte por mail

``` 
Si lo que buscamos es tener un mail con el estado de los volumenes de las 10 mil instancias, se me ocurre que podriamos ejecutar un script por crontab local de cada instancia que tome la info y la suba a una base datos junto con la fecha de update. Luego generamos el reporte desde la base de datos y lo enviamos por mail alertando dependiendo del porcentaje de utilizacion y de fecha de ultimo update de la info. 
```

### Problemática 2:
Dentro de las instancias de AWS, tenemos un script que realiza ciertos monitoreos. Debido a la escala de instancias que tenemos, al necesitar hacer un cambio sobre dicho script se demora mucho tiempo en replicar el cambio. 
- Qué alternativas podemos implementar para que los cambios se apliquen automáticamente?

```
Utilizaria un repositorio para alojar el script y antes de ejecutar nuestra tarea en los servidores remotos hacer un git pull, para que si tenemos algun cambio lo descarguemos y asi ejecutar siempre la ultima version.
```

- Cómo administrarías tantas instancias al mismo tiempo?

```
No me queda claro que significa “al mismo tiempo”, si la pregunta es como ejecutaria algo en las 10.000 instancias en simultaneo, no lo se.
Si lo que se pregunta es como implantaria cambios en 10.000 servidores probablemente seria con una herramienta como Ansible.
```

&nbsp;

---
---
---

&nbsp;

### Base Knowledge
Enumerar al menos 3 comandos en linux, para poder revisar los siguientes casos y que es lo que te puede servir del output de cada uno de ellos.

1. Procesos que están realizando operaciones de escritura o lectura sobre un disco
2. Procesos que estén utilizando alto porcentaje de CPU/memoria

``` 
1. Para analizar este punto utilizaria los siguentes comandos:
iotop:
    para ver que procesos estan realizando lecturas y escrituras en disco y en que volumen.
Pidstat:
    para obtner mas info de un proceso
Iostat:
    para ver info de lecturas y escrituras en cada device

2. Para analizar este punto utilizaria los siguentes comandos:
Top, htop o atop:
     para ver en tiempo real que procesos estan consumiendo mas CPU y Memoria

pidstat:
    para obtner mas info de un proceso
ps:
    podemos ver que usuario esta ejecutando el proceso, que comando esta ejecutando entre otra cosas.
````

1a) Nombrar los componentes Linux Volume Manager (LVM)

```
Phisycal Volumes
Volumes Groups
Logical Volumes
```

1b)Como los puedo usar para escalar hasta un volúmen de 32Tb, teniendo en cuenta que cada uno de mis discos tiene 8Tb de capacidad.

```
Debemos inicializar estos 4 discos de 8Tb como PV’s, posteriormente crear el VG y agregarle los 4 discos. Por ultimo crear un LV utilizando el 100% del espacio disponible en el VG.
pvcreate /dev/<Disco1>
pvcreate /dev/<Disco2>
pvcreate /dev/<Disco3>
pvcreate /dev/<Disco4>
vgcreate data /dev/<Disco1>
vgextend data /dev/<Disco2>
vgextend data /dev/<Disco3>
vgextend data /dev/<Disco4>
lvcreate -n <nombre del volumen> -l 100%FREE data
```

1c) Tenemos una base de datos MySQL corriendo en Linux en una instancia de AWS, y tenemos que tomarle el backup a los volúmenes de datos donde están los binlogs y los datafiles de la DB. (Dos volúmenes LVM) ¿De qué formas se le puede tomar el backup a la DB, que sea consistente y sin interrumpir el servicio de mysql? 

```
Percona tiene un producto que se llama xtrabackup y hace esto.
```

2) Si tuvieras que controlar la performance de un server (con Linux) qué variables tendrías en cuenta y cómo harías un monitoreo con un reporte de estadísticas diarias sobre la performance de dicho equipo.
Teniendo en cuenta CPU, IO a disco, Capacidad utilizada de TODOS los filesystems montados en dicho equipo, y IO Wait.

```
Para analizar el rendimiento del servidor tendria en cuenta el consumo de recursos (CPU, Memoria, acceso y escritura al disco.) Para esto como hablamos anteriormente utilizaria herramientas como TOP, MPSTAT, IOSTAT,IOTOP, DF, FREE, VMSTAT y SAR para generar reportes diarios y enviarlos por correo
```

Base de Datos:

1) Tenemos una base MySQL en una configuración Master - Slave.  El tráfico de la aplicación que la utiliza se compone de un 10% Write y un 90% read.  
Nos reclaman desde Desarrollo que las lecturas se están degradando por el aumento de tráfico durante el Hot-Sale. Desde DBA revisamos las queries, están bien escritas y entran por índice.
- ¿Qué alternativas tenemos para poder soportar el aumento de tráfico sin cambiar el código de la app?

```
Se podria usar un proxysql para dirigir las lecturas a mas replicas.
```

- ¿Y si tuviéramos libertad para cambiar el código? ¿Qué otras opciones podríamos implementar?

```
Implementar algun tipo de cache para las consultas.
```

2) Investigar, nombrar soluciones y comentar. (DBA)
Un equipo está diseñando su base de datos. Nos indican que van a tener grandes volúmenes de datos, pero que solo necesitan los últimos 3 meses online (el resto no se necesita). ¿Qué opciones le podemos plantear para atacar este problema?

```
??? :'(
```