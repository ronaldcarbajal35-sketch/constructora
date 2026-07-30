# DOCUMENTACIÓN DE INGENIERÍA Y DESARROLLO DE SOFTWARE
**Proyecto:** Plataforma Web Empresarial y Aula Virtual para Constructora Salcedo e Ingenieros Consultores E.I.R.L.  
**Entregable:** Informe Técnico de Prácticas Pre-Profesionales / Desarrollo de Software  
**Fecha:** Julio 2026  

---

## 1. PLANTEAMIENTO DEL PROBLEMA Y OBJETIVOS

### 1.1 Antecedentes
*Constructora Salcedo e Ingenieros Consultores E.I.R.L.* es una empresa dedicada al rubro de la ingeniería civil, saneamiento físico-legal, proyectos urbanísticos y servicios de consultoría. Además, la empresa cuenta con una división académica orientada a la capacitación técnica de ingenieros, topógrafos y profesionales afines.

### 1.2 Planteamiento del Problema
La empresa requería una plataforma web moderna capaz de resolver dos necesidades principales:
1. **Presencia Institucional:** Presentar los servicios de obras civiles, saneamiento y expedientes técnicos de manera profesional y accesible.
2. **Plataforma E-Learning / Aula Virtual:** Comercializar y gestionar cursos especializados (Ingeniería Civil, Sistemas e IA, Seguridad Minera), permitiendo a los alumnos acceder a módulos estructurados, reproductor de video, temarios interactivos y recursos descargables.

### 1.3 Objetivos
- **Objetivo General:** Diseñar, desarrollar e implementar una plataforma web empresarial con sistema de catálogo y aula virtual optimizada para alta velocidad de carga, escalabilidad y bajo costo de mantenimiento.
- **Objetivos Específicos:**
  - Aplicar una metodología ágil de desarrollo de software (Scrum/SDLC).
  - Implementar una arquitectura moderna Jamstack utilizando **Astro v4**, **TypeScript** y **TailwindCSS**.
  - Crear un módulo dinámico de administración de cursos mediante Colecciones de Contenido (Content Collections) estructuradas con esquemas Zod.
  - Implementar la interfaz del **Aula Virtual** con reproductor de video, temario interactivo por módulos y barra de progreso.
  - Configurar un pipeline de integración y despliegue continuo (CI/CD) desde **GitHub** hacia la nube en **Vercel**.

---

## 2. METODOLOGÍA DE DESARROLLO DE SOFTWARE (SDLC)

Para el desarrollo del proyecto se adoptó la **Metodología Ágil Scrum** combinada con el Ciclo de Vida del Software (SDLC):

```
+------------------+     +-------------------+     +--------------------+
| 1. Descubrimiento| --> | 2. Arquitectura   | --> | 3. Desarrollo      |
|    & Análisis    |     |    y Diseño UI    |     |    (Sprints Scrum) |
+------------------+     +-------------------+     +--------------------+
                                                             |
+------------------+     +-------------------+               v
| 6. Monitoreo &   | <-- | 5. CI/CD &        | <-- +--------------------+
|    Mantenimiento |     |    Despliegue     |     | 4. QA & Testing    |
+------------------+     +-------------------+     +--------------------+
```

### Fases de Ejecución:
1. **Fase de Análisis de Requerimientos:** Entrevistas y levantamiento de información de los procesos de venta de obras y catálogo de cursos.
2. **Fase de Arquitectura y Diseño:** Definición de la estructura de componentes, paleta de colores (Navy, Brick, Blue, Yellow), tipografía y esquemas de datos.
3. **Fase de Desarrollo Iterativo (Sprints):**
   - *Sprint 1:* Configuración del proyecto base, diseño del Layout, Navbar y Hero.
   - *Sprint 2:* Implementación de servicios institucionales, sección Sobre Nosotros y Footer.
   - *Sprint 3:* Creación del motor de cursos (Content Collections, esquemas de Markdown, filtros por categoría).
   - *Sprint 4:* Desarrollo de las páginas de detalle (`/cursos/[slug]`) y la interfaz del Aula Virtual (`/aula/[slug]`).
4. **Fase de Calidad y Pruebas:** Ejecución de diagnóstico de tipos (`astro check`), prueba de compilación estática (`astro build`) y verificación responsive.
5. **Fase de Despliegue:** Integración con repositorio remoto en GitHub y despliegue automático en la infraestructura cloud de Vercel.

---

## 3. ANÁLISIS DE REQUERIMIENTOS

### 3.1 Requerimientos Funcionales (RF)
- **RF-01 (Catálogo de Cursos):** El sistema debe desplegar un catálogo interactivo de cursos clasificados por categorías (Civil, Sistemas/IA, Minas, etc.).
- **RF-02 (Filtros de Búsqueda):** El usuario debe poder filtrar los cursos por categoría en tiempo real sin recargar la página.
- **RF-03 (Detalle del Curso):** Cada curso debe contar con una página individual que muestre título, descripción, precio, instructor, recursos incluidos y temario desplegable.
- **RF-04 (Aula Virtual):** El sistema debe proveer una interfaz de aula virtual para reproducir las lecciones en video, listar los módulos y permitir descargar material complementario (PDFs, código).
- **RF-05 (Cotizador Directo):** La plataforma debe integrar botones de contacto directo a WhatsApp para la cotización de obras e inscripción en cursos.
- **RF-06 (Servicios Institucionales):** Mostrar la oferta de construcción de edificios, saneamiento físico-legal y expedientes técnicos.

### 3.2 Requerimientos No Funcionales (RNF)
- **RNF-01 (Rendimiento):** La velocidad de carga inicial debe ser menor a 1.5 segundos (Static Site Generation - SSG).
- **RNF-02 (Diseño Responsive):** La interfaz debe adaptarse a dispositivos móviles, tablets y computadoras de escritorio.
- **RNF-03 (Mantenibilidad):** El código debe seguir una arquitectura basada en componentes reutilizables y tipado estricto con TypeScript.
- **RNF-04 (SEO y Accesibilidad):** Implementar metaetiquetas semánticas HTML5, etiquetas OpenGraph y optimización de imágenes (`astro:assets`).
- **RNF-05 (Disponibilidad):** La plataforma debe desplegarse en una infraestructura cloud con 99.9% de disponibilidad (Vercel Edge Network).

---

## 4. ARQUITECTURA DEL SISTEMA Y ESTRUCTURA DE CÓDIGO

### 4.1 Patrón de Arquitectura (Jamstack)
Se seleccionó el patrón **Jamstack** (JavaScript, APIs, Markup):
- **Frontend / Framework:** Astro v4 (Framework enfocado en rendimiento con islas de componentes).
- **Estilos:** TailwindCSS (Diseño con clases de utilidad y tokens de color personalizados).
- **Contenidos / Base de Datos:** Astro Content Collections (Archivos Markdown tipados con Zod).

### 4.2 Estructura de Directorios del Proyecto
```
constructora/
├── public/                     # Recursos estáticos (Imágenes, SVG, Favicon)
│   ├── images/
│   └── favicon.svg
├── src/
│   ├── assets/                 # Imágenes procesadas por Astro (_astro)
│   ├── components/             # Componentes UI reutilizables
│   │   ├── Navbar.astro        # Navegación principal con menú mobile
│   │   ├── Hero.astro          # Encabezado institucional
│   │   ├── Services.astro      # Tarjetas de servicios de construcción
│   │   ├── Academy.astro       # Rejilla de cursos con filtro dinámico
│   │   ├── About.astro         # Información institucional de la empresa
│   │   └── Footer.astro        # Pie de página y enlaces de contacto
│   ├── content/                # Colecciones de contenido (Markdown)
│   │   ├── config.ts           # Definición del esquema Zod de cursos
│   │   └── cursos/             # Archivos .md de cada curso
│   ├── layouts/
│   │   └── Layout.astro        # Plantilla base con meta-tags y fuentes
│   └── pages/                  # Enrutamiento basado en archivos
│       ├── index.astro         # Página principal (Landing Page)
│       ├── cursos/[slug].astro # Página dinámica de temario del curso
│       └── aula/[slug].astro   # Interfaz del Aula Virtual y reproductor
├── astro.config.mjs            # Configuración de Astro e integraciones
├── package.json                # Dependencias y scripts de ejecución
├── tailwind.config.mjs         # Configuración del sistema de diseño
└── tsconfig.json               # Configuración del compilador TypeScript
```

### 4.3 Esquema de Datos de Cursos (`src/content/config.ts`)
```typescript
import { defineCollection, z } from 'astro:content';

const cursosCollection = defineCollection({
    type: 'content',
    schema: ({ image }) => z.object({
        title: z.string(),
        description: z.string(),
        price: z.number(),
        category: z.enum(['civil', 'sistemas', 'minas', 'software']),
        image: image(),
        instructor: z.object({
            name: z.string(),
            role: z.string(),
            avatar: z.string().optional(),
        }),
        syllabus: z.array(z.object({
            title: z.string(),
            items: z.array(z.string()),
        })),
    }),
});
```

---

## 5. PROCEDIMIENTO DE IMPLEMENTACIÓN Y CÓDIGO FUENTE

### 5.1 Creación de Rutas Dinámicas (`src/pages/cursos/[slug].astro`)
Astro utiliza la función `getStaticPaths()` para compilar estáticamente una página HTML por cada archivo Markdown presente en la colección:

```astro
export async function getStaticPaths() {
  const cursos = await getCollection('cursos');
  return cursos.map(entry => ({
    params: { slug: entry.slug },
    props: { entry },
  }));
}
```

### 5.2 Implementación del Aula Virtual (`src/pages/aula/[slug].astro`)
El aula virtual proporciona una experiencia de aprendizaje inmersiva en modo oscuro:
- **Área Principal:** Reproductor de video centrado con controles, títulos y botones de descarga de materiales (PDF / ZIP).
- **Barra Lateral Derecha:** Lista interactiva de módulos y lecciones obtenidas dinámicamente desde el temario del curso con indicador de progreso.

---

## 6. PRUEBAS, CONTROL DE CALIDAD Y DESPLIEGUE CONTINUO (CI/CD)

### 6.1 Verificación Estática y Compilación
Antes de cada despliegue se ejecutan los siguientes comandos de control de calidad:
1. **Diagnóstico de tipos:** `npx astro check` (Garantiza 0 errores TypeScript).
2. **Compilación de producción:** `npm run build` (Genera la carpeta dist/ optimizada).

### 6.2 Pipeline CI/CD con GitHub y Vercel
```
[Computadora Local] 
       │ (git commit & git push)
       ▼
[Repositorio GitHub: ronaldcarbajal35-sketch/constructora]
       │ (Webhook de Vercel)
       ▼
[Vercel Cloud Build Machine]
       ├── Installing dependencies (npm install)
       ├── Executing "npm run build"
       └── Deploying to Edge Network (HTTPS SSL)
```

---

## 7. CONCLUSIONES

1. Se logró desarrollar exitosamente la plataforma web institucional y el aula virtual para **Constructora Salcedo**, satisfaciendo los requerimientos de la empresa y la demanda de capacitación técnica en la región.
2. La arquitectura basada en **Astro v4 + Jamstack** permitió obtener una velocidad de carga óptima y costos de infraestructura cero al desplegarse sobre la capa gratuita de Vercel.
3. El uso de **Content Collections** con validación de esquemas Zod garantiza que la adición de nuevos cursos se realice de forma estructurada, rápida y segura sin riesgo de romper la interfaz.
