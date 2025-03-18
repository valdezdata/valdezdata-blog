---
layout: post.njk
title: Cómo Nació la Arquitectura de Datos Moderna
date: 2025-03-18
tags:
  [
    "datawarehouse",
    "datalake",
    "datalakehouse",
    "bigdata",
    "dataarchitect",
    "metadata",
    "etl",
    "datastrategy",
  ]
excerpt: Descubre la evolución de la arquitectura de datos moderna y su impacto en la industria.
---

### TL;DR

La arquitectura de datos ha pasado de los costosos y rígidos data warehouses relacionales a los flexibles data lakes y, finalmente, al data lakehouse, que combina lo mejor de ambos mundos. Gracias a la nube, ahora es más sencillo escalar y manejar distintos tipos de datos, pero el orden (metadata) y las vías de acceso (APIs) siguen siendo clave para encontrar valor rápidamente en toda esta información.

### Video

Si deseas ver video en vez de leer, [haz click aquí.](https://www.youtube.com/watch?v=lMP7U6HCTQk)

<div style="text-align: center;">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/lMP7U6HCTQk" 
        frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
        allowfullscreen>
    </iframe>
</div>

&nbsp;

## > cat intro.txt

En algún momento, los datos que una empresa manejaba podían almacenarse cómodamente en un único servidor. Hoy, la realidad es muy distinta: la nube es el hogar de nuestras enormes cantidades de datos. Este cambio no ocurrió de la noche a la mañana. Veamos cómo la arquitectura de datos ha evolucionado a lo largo del tiempo y los nuevos retos a los que nos enfrentamos hoy.

### Por Qué Importa la Arquitectura de Datos

Imagina que en tu cocina todo estuviera desordenado: te costaría encontrar tus ingredientes, algunos se echarían a perder, y podrías terminar cocinando algo que no necesitas. Lo mismo sucede con los datos. Sin un plan de organización y almacenamiento, es fácil perderse en el caos de la información.

## > cat body.txt

### **El Comienzo: Data Warehouse Relacional**

En los años 80, el data warehouse relacional era la estrella del show. Este tipo de almacén de datos, iniciado por Teradata en 1983, permitió a las empresas almacenar y consultar datos en un único sistema. Sin embargo, ampliar la capacidad de almacenamiento era costoso y complicado.

En esencia, era como una biblioteca en la que para agregar estantes había que reconstruir el edificio.

### **El Avance: Data Lake**

Llegamos al 2010 y con ello a la aparición del "data lake" gracias a Hadoop. Ahora las empresas podían almacenar grandes cantidades de datos en su forma pura y sin procesar. Esto solucionaba algunos problemas del pasado, pero presentaba nuevos retos: obtener la información útil era como buscar una aguja en un pajar, ya que las empresas estaban gestionando más datos de los que podían manejar efectivamente.

### **La Nube y el Modern Data Warehouse**

La introducción de la nube cambió mucho las cosas. Ya no necesitábamos servidores físicos para almacenar datos. La nube nos permitió alquilar almacenamiento según nuestras necesidades, ofreciéndonos flexibilidad para manejar tanto texto como imágenes o datos en streaming.

Esto condujo al nacimiento del Modern Data Warehouse, una mezcla de lo mejor de los métodos anteriores, aprovechando la flexibilidad de los data lakes mientras mantenía la organización del data warehouse.

### **La Era del Data Lakehouse**

En 2020, el concepto del data lakehouse salió a la luz. Se buscaba crear un entorno único donde todo tipo de datos—estructurados o no—pudieran almacenarse juntos. Una capa de software permitiría que funcionara como una base de datos tradicional, ofreciendo lo mejor de ambos mundos: la gestión eficiente y la flexibilidad de almacenamiento.

### **Elementos Cruciales: Metadata y APIs**

Para que el data lakehouse funcione bien, dos componentes son esenciales: metadata y APIs. La metadata actúa como un índice que ayuda a entender y utilizar los datos adecuadamente en cada etapa.

Las APIs son los accesos directos, facilitando el intercambio de datos pulidos entre sistemas, lo cual es crucial para obtener información útil rápidamente.

&nbsp;

## > cat outro.txt

La arquitectura de datos nunca deja de evolucionar. Siempre habrá nuevos problemas que resolver, pero cada desafío nos brinda la oportunidad de innovar y aprender.

&nbsp;

```bash
echo "En los datos, la única constante es el cambio" > /dev/stdout
```
