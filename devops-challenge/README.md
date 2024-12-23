# X Devops/CloudOps Test
## Devops Test goals

En este test deberás ser capaz de crear la infraestructura básica con tus conocimientos en DevOps, consideramos que la infraestructura como código es una de las prácticas básicas en devOps, intentamos aprovisionar todos los recursos tan automatizadamente como sea posible.

(crea un fork de este repo y adjunta tus solución)

* La tarea, para cada punto puedes utilizar la siguiente estructura:

```
./
├─ 1_docker
│  └─ <your project>
├─ 2_infrastructure
│  └─ <your project>
├─ 3_automation
│  └─ <your project>
└─ 4_scripting
   └─ <your project>
```

1. Docker Container
  - Dockeriza la API (carpeta app/) 
  - Provisiona la app con docker compose en el puerto 9200

**puntos extra por:**
- Utiliza multi-stage bulds

2. Infraestructura
Para nuestra API, diseña y crea la infraestructura básica para AWS, AZURE o GCP usando una herramienta como Cloudformation o Terraform. La Api debe ser expuesta por internet con algún mecanismo de autorización/autenticación básicos (apikey por ejemplo)

**puntos extra por:**
- Explicar claramente por qué estás haciendo cada cosa.
- Agrega un diagrama PNG de la infraestructura

3. Automatización
Crea un pipeline de CI/CD usando la herramienta que desees que permita realizar el despliegue de la API en cada commit a la rama master, en el proveedor de nube seleccionado en el item 2.

4. Coding test (scripting)
Crea una aplicación básica en java, python, nodejs o el lenguaje que desees, la app debe hacer algo que normalmente haces de forma manual. Algunas ideas:
  
  - Recuperar información de una fuente externa y presentarla, por ejemplo el status de un servidor o el espacio libre en disco
  - Backup de BD local y que lo suba a la nube a algún servicio de almacenamiento


## Criterios de evaluación
- Documentación clara
- Fácil lectura y entendimiento del código
- Correcto uso de las herramientas seleccionadas
- Flexibilidad y extensibilidad de la solución propuesta