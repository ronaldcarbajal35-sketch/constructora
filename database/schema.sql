-- =============================================================================
-- ESQUEMA DE BASE DE DATOS POSTGRESQL / SUPABASE
-- PROYECTO: PLATAFORMA Y AULA VIRTUAL CONSTRUCTORA SALCEDO
-- =============================================================================

-- 1. Tabla de Categorías
CREATE TABLE IF NOT EXISTS categorias (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    slug VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertar categorías por defecto
INSERT INTO categorias (nombre, slug, descripcion) VALUES
('Ingeniería Civil', 'civil', 'Cursos de residencia, supervisión y obras civiles'),
('Sistemas e IA', 'sistemas', 'Cursos de inteligencia artificial y tecnología aplicada'),
('Seguridad Minera', 'minas', 'Cursos de gestión de riesgos y seguridad en minería'),
('Desarrollo de Software', 'software', 'Cursos de desarrollo web, móvil y arquitectura')
ON CONFLICT (slug) DO NOTHING;

-- 2. Tabla de Cursos
CREATE TABLE IF NOT EXISTS cursos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    categoria_id UUID REFERENCES categorias(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    image_url TEXT,
    instructor_name VARCHAR(100) NOT NULL,
    instructor_role VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Tabla de Módulos
CREATE TABLE IF NOT EXISTS modulos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    curso_id UUID NOT NULL REFERENCES cursos(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    position INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Tabla de Lecciones / Video
CREATE TABLE IF NOT EXISTS lecciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    modulo_id UUID NOT NULL REFERENCES modulos(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    video_url TEXT NOT NULL,
    duration_minutes INT DEFAULT 10,
    resource_pdf_url TEXT,
    resource_code_url TEXT,
    position INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Tabla de Contactos y Cotizaciones (Leads de Obra y Cursos)
CREATE TABLE IF NOT EXISTS contactos_cotizaciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre_completo VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    tipo_servicio VARCHAR(100) NOT NULL, -- 'Construcción', 'Saneamiento', 'Expediente', 'Curso'
    mensaje TEXT,
    estado VARCHAR(50) DEFAULT 'Pendiente', -- 'Pendiente', 'Atendido', 'Cerrado'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Habilitar Row Level Security (RLS) para lectura pública de Cursos
ALTER TABLE cursos ENABLE ROW LEVEL SECURITY;
ALTER TABLE modulos ENABLE ROW LEVEL SECURITY;
ALTER TABLE lecciones ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Permitir lectura publica de cursos" ON cursos FOR SELECT USING (true);
CREATE POLICY "Permitir lectura publica de modulos" ON modulos FOR SELECT USING (true);
CREATE POLICY "Permitir lectura publica de lecciones" ON lecciones FOR SELECT USING (true);
CREATE POLICY "Permitir insertar cotizaciones" ON contactos_cotizaciones FOR INSERT WITH CHECK (true);
