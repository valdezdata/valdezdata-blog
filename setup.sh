#!/bin/bash

# Create necessary directories
mkdir -p _includes _data blog css js assets whoami usos

# Copy files to their respective locations
# Base layout
cat >_includes/base.njk <<'EOL'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ title }} | VALDEZDATA</title>
  <link rel="stylesheet" href="/css/style.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
  <div class="terminal">
    <div class="terminal-header">
      <div class="terminal-buttons">
        <div class="terminal-button red"></div>
        <div class="terminal-button yellow"></div>
        <div class="terminal-button green"></div>
      </div>
      <div class="terminal-title">valdezdata@blog:~</div>
    </div>
    
    <div class="terminal-content">
      <div class="ascii-header">
        <pre>
██╗   ██╗ █████╗ ██╗     ██████╗ ███████╗███████╗██████╗  █████╗ ████████╗ █████╗ 
██║   ██║██╔══██╗██║     ██╔══██╗██╔════╝╚══███╔╝██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
██║   ██║███████║██║     ██║  ██║█████╗    ███╔╝ ██║  ██║███████║   ██║   ███████║
╚██╗ ██╔╝██╔══██║██║     ██║  ██║██╔══╝   ███╔╝  ██║  ██║██╔══██║   ██║   ██╔══██║
 ╚████╔╝ ██║  ██║███████╗██████╔╝███████╗███████╗██████╔╝██║  ██║   ██║   ██║  ██║
  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
        </pre>
      </div>
      
      <div class="typing-container">
        <div class="typing-text" id="typing-text"></div>
        <div class="cursor"></div>
      </div>
      
      <div class="tags-container">
        {% for tag in ['#dataengineering', '#datainfra', '#mlops', '#dataintegrity', '#ai', '#dataops', '#security'] %}
          <span class="tag">{{ tag }}</span>
        {% endfor %}
      </div>
      
      <nav class="terminal-nav">
        <ul>
          <li><a href="/whoami/">> whoami</a></li>
          <li><a href="/usos/">> Usos</a></li>
          <li><a href="/">> home</a></li>
        </ul>
      </nav>
      
      <div class="content">
        {{ content | safe }}
      </div>
      
      <div class="terminal-footer">
        <p>© {{ "now" | date: "%Y" }} VALDEZDATA - Built with <a href="https://www.11ty.dev/">11ty</a> and 💙</p>
      </div>
    </div>
  </div>
  
  <script src="/js/terminal.js"></script>
</body>
</html>
EOL

# Eleventy configuration
cat >.eleventy.js <<'EOL'
module.exports = function(eleventyConfig) {
  // Pass through copy for CSS and other assets
  eleventyConfig.addPassthroughCopy("css");
  eleventyConfig.addPassthroughCopy("js");
  eleventyConfig.addPassthroughCopy("assets");
  
  // Add a date filter
  eleventyConfig.addFilter("dateFormat", function(date) {
    return new Date(date).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  });

  // Add a simpler date filter
  eleventyConfig.addFilter("date", function(date, format) {
    if (format === "%Y") {
      return new Date().getFullYear();
    }
    return new Date(date).toLocaleDateString();
  });

  // Configure blog post collection
  eleventyConfig.addCollection("posts", function(collectionApi) {
    return collectionApi.getFilteredByGlob("blog/*.md").reverse();
  });

  return {
    dir: {
      input: ".",
      output: "_site",
      includes: "_includes",
      data: "_data"
    },
    templateFormats: ["md", "njk", "html"],
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    dataTemplateEngine: "njk"
  };
};
EOL

# Home page
cat >index.njk <<'EOL'
---
layout: base.njk
title: Home
---

<div class="post-list">
  {% if collections.posts.length > 0 %}
    <h2 class="command-prompt">> ls -la blog/</h2>
    
    {% for post in collections.posts %}
      <article class="post-item">
        <h2 class="post-title">
          <a href="{{ post.url }}">{{ post.data.title }}</a>
        </h2>
        <div class="post-meta">
          <time datetime="{{ post.date | dateFormat }}">{{ post.date | dateFormat }}</time>
          {% if post.data.tags %}
            • 
            {% for tag in post.data.tags %}
              {% if tag != "post" %}
                <span class="tag">{{ tag }}</span>
              {% endif %}
            {% endfor %}
          {% endif %}
        </div>
        <div class="post-excerpt">
          {% if post.data.excerpt %}
            {{ post.data.excerpt }}
          {% else %}
            {{ post.templateContent | striptags | truncate(150) }}
          {% endif %}
        </div>
        <a href="{{ post.url }}" class="read-more">Read more ></a>
      </article>
    {% endfor %}
    
    {% if collections.posts.length > 5 %}
      <div class="pagination">
        <a href="/blog/page-2/">next ></a>
      </div>
    {% endif %}
  {% else %}
    <p>> echo "No posts found. Create your first post in the blog directory."</p>
  {% endif %}
</div>
EOL

# CSS File
cat >css/style.css <<'EOL'
:root {
  /* Tokyo Night Theme Colors */
  --bg-color: #1a1b26;
  --text-color: #a9b1d6;
  --accent-color: #7aa2f7;
  --secondary-color: #bb9af7;
  --prompt-color: #9ece6a;
  --link-color: #7dcfff;
  --highlight-color: #ff9e64;
  --error-color: #f7768e;
  --success-color: #9ece6a;
  --warning-color: #e0af68;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'JetBrains Mono', monospace;
  background-color: #16161e;
  color: var(--text-color);
  line-height: 1.6;
  padding: 20px;
  display: flex;
  justify-content: center;
}

.terminal {
  width: 100%;
  max-width: 900px;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
  margin: 20px auto;
}

.terminal-header {
  background-color: #24283b;
  padding: 10px 15px;
  display: flex;
  align-items: center;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
}

.terminal-buttons {
  display: flex;
  gap: 6px;
  margin-right: 20px;
}

.terminal-button {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.terminal-button.red {
  background-color: var(--error-color);
}

.terminal-button.yellow {
  background-color: var(--warning-color);
}

.terminal-button.green {
  background-color: var(--success-color);
}

.terminal-title {
  color: var(--text-color);
  font-size: 14px;
  flex-grow: 1;
  text-align: center;
}

.terminal-content {
  background-color: var(--bg-color);
  padding: 20px;
  min-height: 500px;
}

.ascii-header {
  color: var(--accent-color);
  font-size: 10px;
  line-height: 1;
  margin-bottom: 20px;
  text-align: center;
  overflow-x: auto;
}

.typing-container {
  display: flex;
  margin-bottom: 15px;
  height: 20px;
}

.typing-text {
  color: var(--prompt-color);
  font-weight: bold;
}

.cursor {
  width: 10px;
  height: 18px;
  margin-left: 2px;
  background-color: var(--prompt-color);
  animation: blink 1s infinite;
}

@keyframes blink {
  0%, 49% { opacity: 1; }
  50%, 100% { opacity: 0; }
}

.tags-container {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 20px;
  font-size: 14px;
}

.tag {
  color: var(--highlight-color);
}

.terminal-nav {
  margin-bottom: 30px;
  border-bottom: 1px solid #24283b;
  padding-bottom: 10px;
}

.terminal-nav ul {
  list-style: none;
  display: flex;
  gap: 20px;
}

.terminal-nav a {
  color: var(--link-color);
  text-decoration: none;
  transition: all 0.3s ease;
}

.terminal-nav a:hover {
  color: var(--accent-color);
  text-decoration: underline;
}

.content {
  padding-top: 20px;
}

.post-list {
  margin-bottom: 30px;
}

.post-item {
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px dashed #24283b;
}

.post-item:last-child {
  border-bottom: none;
}

.post-title {
  color: var(--secondary-color);
  margin-bottom: 5px;
}

.post-title a {
  color: inherit;
  text-decoration: none;
}

.post-title a:hover {
  color: var(--accent-color);
  text-decoration: underline;
}

.post-meta {
  font-size: 14px;
  color: var(--text-color);
  opacity: 0.7;
  margin-bottom: 10px;
}

.post-excerpt {
  margin-bottom: 10px;
}

.read-more {
  color: var(--link-color);
  text-decoration: none;
}

.read-more:hover {
  text-decoration: underline;
}

.pagination {
  display: flex;
  justify-content: space-between;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #24283b;
}

.pagination a {
  color: var(--link-color);
  text-decoration: none;
}

.pagination a:hover {
  color: var(--accent-color);
  text-decoration: underline;
}

.terminal-footer {
  margin-top: 50px;
  padding-top: 20px;
  border-top: 1px solid #24283b;
  text-align: center;
  font-size: 14px;
  color: var(--text-color);
  opacity: 0.7;
}

.terminal-footer a {
  color: var(--link-color);
  text-decoration: none;
}

.terminal-footer a:hover {
  text-decoration: underline;
}

/* Blog post styles */
.post-content h1, 
.post-content h2, 
.post-content h3, 
.post-content h4, 
.post-content h5, 
.post-content h6 {
  color: var(--secondary-color);
  margin-top: 30px;
  margin-bottom: 15px;
}

.post-content p {
  margin-bottom: 20px;
}

.post-content code {
  background-color: #24283b;
  padding: 2px 5px;
  border-radius: 3px;
}

.post-content pre {
  background-color: #24283b;
  padding: 15px;
  border-radius: 5px;
  overflow-x: auto;
  margin-bottom: 20px;
}

.post-content a {
  color: var(--link-color);
  text-decoration: none;
}

.post-content a:hover {
  text-decoration: underline;
}

.post-content ul, 
.post-content ol {
  margin-bottom: 20px;
  padding-left: 20px;
}

.post-content blockquote {
  border-left: 3px solid var(--accent-color);
  padding-left: 15px;
  color: var(--text-color);
  opacity: 0.9;
  margin-bottom: 20px;
}

@media (max-width: 768px) {
  .terminal {
    width: 95%;
  }
  
  .ascii-header pre {
    font-size: 6px;
  }
  
  .terminal-nav ul {
    flex-direction: column;
    gap: 10px;
  }
}
EOL

# JS File
cat >js/terminal.js <<'EOL'
document.addEventListener('DOMContentLoaded', () => {
  // Typing effect for the tagline
  const typingText = document.getElementById('typing-text');
  const text = 'desbloqueando el potencial de los datos';
  let i = 0;
  const typingSpeed = 100; // milliseconds per character

  function typeWriter() {
    if (i < text.length) {
      typingText.innerHTML += text.charAt(i);
      i++;
      setTimeout(typeWriter, typingSpeed);
    }
  }

  // Start the typing animation after a short delay
  setTimeout(typeWriter, 1000);

  // Simulate terminal behavior with links
  const terminalLinks = document.querySelectorAll('.terminal-nav a, .post-title a, .read-more, .pagination a');
  
  terminalLinks.forEach(link => {
    link.addEventListener('click', function(e) {
      // Only process if it's an internal link
      if (this.hostname === window.location.hostname) {
        e.preventDefault();
        const href = this.getAttribute('href');
        
        // Add a command-like output before navigating
        const commandOutput = document.createElement('div');
        commandOutput.classList.add('command-output');
        commandOutput.innerHTML = `<span class="prompt">$</span> cd ${href}`;
        document.querySelector('.content').appendChild(commandOutput);
        
        // Navigate after a short delay
        setTimeout(() => {
          window.location.href = href;
        }, 500);
      }
    });
  });
});
EOL

# Whoami page
mkdir -p whoami
cat >whoami/index.md <<'EOL'
---
layout: base.njk
title: whoami
---

# > whoami

```
User: valdezdata
Role: Data Engineer / Data Scientist
Location: /home/valdezdata
```

## > cat about.txt

Soy un profesional apasionado por los datos y la tecnología, especializado en crear infraestructuras de datos robustas, escalables y seguras.

Mi misión es desbloquear el potencial de los datos para impulsar decisiones basadas en evidencia y crear soluciones innovadoras que transformen la forma en que las organizaciones aprovechan sus activos de información.

## > ls -la skills/

```
drwxr-xr-x  data-engineering/
drwxr-xr-x  cloud-infrastructure/
drwxr-xr-x  machine-learning/
drwxr-xr-x  data-privacy/
-rw-r--r--  python.py
-rw-r--r--  sql.sql
-rw-r--r--  docker-compose.yml
-rw-r--r--  terraform.tf
```

## > cat contact.txt

Para proyectos, colaboraciones o simplemente conversar sobre datos:

- Email: [correo@valdezdata.com](mailto:correo@valdezdata.com)
- LinkedIn: [valdezdata](https://linkedin.com/in/valdezdata)
- GitHub: [valdezdata](https://github.com/valdezdata)

```bash
echo "¡Gracias por visitar!" > /dev/stdout
```
EOL

# Usos page
mkdir -p usos
cat >usos/index.md <<'EOL'
---
layout: base.njk
title: Usos
---

# > cat usos.txt

Esta página detalla las herramientas, tecnologías y configuraciones que uso diariamente para mi trabajo con datos.

## Hardware

```
$ system_profiler
  
MacBook Pro (2021, M1 Pro)
RAM: 32GB
Storage: 1TB SSD
Monitors: 2 x Dell UltraSharp 27"
```

## Software para Ingeniería de Datos

```
$ dpkg --list | grep data-tools

- dbt (data build tool)
- Apache Airflow
- Apache Spark
- Snowflake
- Kafka
- Metabase
- Terraform
- Docker + Kubernetes
```

## Editor y Terminal

```
$ echo $EDITOR
VS Code con Tokyo Night Theme

$ echo $SHELL
zsh + Oh My Zsh + Starship prompt
Terminal: iTerm2
```

## Lenguajes y Frameworks

```
$ ls -la ~/languages/
  
Python/
├── pandas
├── pyspark
├── scikit-learn
├── tensorflow
├── fastapi
└── pytest

SQL/
Go/
Rust/ (aprendiendo)
```

## Cloud

```
$ aws configure list
AWS, GCP y Azure para diferentes proyectos

Servicios favoritos:
- AWS Lambda
- Google BigQuery
- AWS S3
- Google Cloud Functions
- Azure Data Factory
```

## Productividad

```
$ crontab -l | grep productividad
Notion para notas y documentación
Obsidian para conocimiento personal
Superhuman para email
Rectangle para gestión de ventanas
```
EOL

# Sample blog post
mkdir -p blog
cat >blog/first-post.md <<'EOL'
---
title: Construyendo Data Pipelines Resilientes con Airflow
date: 2023-01-15
tags: ['data-engineering', 'airflow', 'python']
excerpt: Una exploración de mejores prácticas para crear data pipelines robustos y resilientes utilizando Apache Airflow.
---

# Construyendo Data Pipelines Resilientes con Airflow

En el mundo de la ingeniería de datos, la resiliencia no es negociable. Los pipelines de datos deben funcionar de manera confiable, incluso cuando ocurren fallos inevitables. Apache Airflow se ha convertido en una herramienta estándar para orquestar pipelines complejos, pero construir flujos verdaderamente resilientes requiere más que simplemente definir DAGs.

## El Problema de los Pipelines Frágiles

Muchos pipelines de datos fallan por razones predecibles:

```python
# ❌ Pipeline frágil sin manejo de errores
def extract_data():
    # Si la API falla, todo el pipeline falla
    response = requests.get('https://api.example.com/data')
    response.raise_for_status()
    return response.json()
```

## Implementando Retries Inteligentes

Airflow permite implementar retries a nivel de tarea:

```python
# ✅ Tarea con retries configurados
extract_task = PythonOperator(
    task_id='extract_data',
    python_callable=extract_data,
    retries=3,
    retry_delay=timedelta(minutes=5),
    retry_exponential_backoff=True,
    dag=dag
)
```

## Estrategias de Idempotencia

Una clave para la resiliencia es la idempotencia - la capacidad de ejecutar un proceso múltiples veces sin efectos secundarios:

```python
# ✅ Función idempotente
def load_to_warehouse(data, execution_date):
    # Usar una clave temporal para garantizar idempotencia
    date_key = execution_date.strftime('%Y-%m-%d')
    
    # Primero eliminar registros existentes de este período
    warehouse.delete_where(date=date_key)
    
    # Luego insertar los nuevos datos
    warehouse.insert(data, date=date_key)
```

## Monitoreo y Alertas

La resiliencia también requiere visibilidad. Configurar alertas efectivas es crucial:

```python
# Configuración de alertas en Airflow
default_args = {
    'owner': 'data_team',
    'depends_on_past': False,
    'email': ['alerts@company.com'],
    'email_on_failure': True,
    'email_on_retry': False,
}
```

## Conclusión

Construir pipelines resilientes con Airflow es un equilibrio entre anticipar fallos, implementar retries inteligentes, garantizar idempotencia y mantener una buena visibilidad del sistema. Estas prácticas no solo evitan llamadas de emergencia a media noche, sino que también aseguran la integridad y disponibilidad de los datos en toda la organización.

En próximos posts, exploraremos patrones avanzados de Airflow como los sensores dinámicos y estrategias para manejar dependencias externas.

```bash
echo "Happy data engineering!" > /dev/stdout
```
EOL

# Second blog post
cat >blog/second-post.md <<'EOL'
---
title: Asegurando la Integridad de Datos con dbt Tests
date: 2023-02-10
tags: ['data-integrity', 'dbt', 'testing']
excerpt: Cómo implementar una estrategia robusta de pruebas para asegurar la calidad e integridad de tus datos con dbt.
---

# Asegurando la Integridad de Datos con dbt Tests

En el mundo de los datos, la confianza es fundamental. Para que los stakeholders tomen decisiones basadas en datos, necesitan tener plena confianza en la integridad de esos datos. Aquí es donde dbt (data build tool) y su sistema de pruebas se vuelven esenciales para cualquier stack moderno de datos.

## ¿Por qué necesitamos pruebas de datos?

Sin pruebas sistemáticas, los problemas comunes incluyen:

- Valores duplicados en columnas que deberían ser únicas
- Referencias huérfanas a registros que no existen
- Valores nulos en campos críticos
- Anomalías estadísticas o outliers

## Pruebas incorporadas en dbt

dbt viene con cuatro pruebas genéricas que pueden solucionar la mayoría de los casos de uso básicos:

```yaml
# models/schema.yml
version: 2

models:
  - name: customers
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null
      
      - name: plan_type
        tests:
          - accepted_values:
              values: ['free', 'starter', 'professional', 'enterprise']
      
      - name: service_rep_id
        tests:
          - relationships:
              to: ref('service_reps')
              field: id
```

## Pruebas personalizadas para lógica de negocio

Las pruebas incorporadas son solo el comienzo. Para reglas de negocio específicas, podemos crear pruebas personalizadas:

```sql
-- tests/total_should_match_detail.sql
{% test total_should_match_detail(model, total_column, detail_table, detail_sum_column) %}

with 

total_values as (
    select 
        order_id,
        {{ total_column }} as total_amount
    from {{ model }}
),

detail_values as (
    select 
        order_id,
        sum({{ detail_sum_column }}) as detail_total
    from {{ ref(detail_table) }}
    group by 1
),

mismatches as (
    select
        t.order_id,
        t.total_amount,
        d.detail_total,
        abs(t.total_amount - d.detail_total) as diff
    from total_values t
    join detail_values d on t.order_id = d.order_id
    where abs(t.total_amount - d.detail_total) > 0.01
)

select * from mismatches

{% endtest %}
```

## Implementación en tu flujo de trabajo

Para integrar las pruebas en tu pipeline:

```bash
# Ejecutar todas las pruebas
dbt test

# Ejecutar pruebas específicas
dbt test --models customers

# Pruebas como parte del CI/CD
dbt build  # combina dbt run y dbt test
```

## Monitoreando la calidad de datos a lo largo del tiempo

Las pruebas puntuales son útiles, pero el monitoreo continuo es mejor:

1. Programa ejecuciones de pruebas regulares (diarias/horarias)
2. Integra alertas cuando fallen las pruebas
3. Construye dashboards de calidad de datos

## Conclusión

Invertir en pruebas de datos desde el principio paga dividendos enormes a largo plazo: mejora la confianza, reduce el tiempo de depuración y permite refactorizar con confianza. dbt proporciona las herramientas necesarias para implementar una cultura de calidad de datos en tu organización.

```bash
echo "Datos confiables, decisiones confiables." > /dev/stdout
```
EOL

# Run Eleventy
echo "Setup completed! Now run these commands to start your site:"
echo "npm install"
echo "npm start"
