# ZOODEX

Esta es una **API/backend** para una plataforma informativa sobre animales llamada **ZOODEX**, diseñada para ofrecer funcionalidades completas de **consulta, filtrado, rankings y administración de un extenso catálogo de animales**, siendo **robusta, segura y escalable**.

⚠️ **Dependencia:** Esta aplicación está construida para ser consumida por el frontend de **ZOODEX**.

---

### Funcionalidades para la API:

- **Autenticación completa**:
  - Login de administrador mediante **JWT**.
- **Gestión de animales**:
  - Visualización de animales con toda su información detallada.
  - Edición completa de animales (solo admin):
    - Categoría (mamíferos, reptiles, anfibios, aves, marinos).
    - Subcategoría (felinos, caninos, bovinos, ovinos, caprinos, osos, etc.).
    - Tipo (terrestre, volador, acuático, semiacuático, arbóreo, doméstico).
    - Dieta (carnívoro, herbívoro, omnívoro).
    - Propiedades específicas según la categoría.
- **Catálogo avanzado de animales**:
  - Listado por categorías.
  - Listado por subcategorías.
  - Listado por tipo.
  - Listado por dieta.
  - Todos o casi todos, mediante parámetros para ser mostrados con paginación.
- **Animales destacados**:
  - Obtención de animales aleatorios para mostrar en el inicio.
- **Rankings de animales**:
  - Rankings por distintas métricas:
    - Más inteligentes.
    - Más altos.
    - Más pesados.
    - Más longevos.
    - Más rápidos.
    - Más peligrosos.
  - Visualización de rankings completos.
  - Inclusión del valor asociado y posición en el ranking.
- **Buscador**:
  - Búsqueda de animales por nombre.
  - Búsqueda de animales por ID.
- **Sistema de administración**:
  - Acceso exclusivo para administradores.
  - Edición total de los datos de los animales.
- **Protección de rutas** mediante **JWT**.
- **Middleware de seguridad**:
  - Validación de tokens JWT.
  - Restricción de acceso a endpoints administrativos.
- **Validación de datos**:
  - Uso de **Django Rest Framework Serializers**.
  - Validadores personalizados para sanitizar y validar datos:
    - `escape` para evitar inyecciones HTML.
    - Expresiones regulares (`re`) para validaciones avanzadas.
    - Uso de tipos estrictos como `Decimal`.
- **CORS habilitado**, preparado para trabajar con frontend externo.
- **Envío de emails automáticos**:
  - Notificaciones del sistema.
  - Usando el servicio de **Brevo** (`sib-api-v3-sdk`).

---

### Variables de entorno

Crea un archivo `.env` en la raíz del proyecto y añade tus propios datos:

```bash
SECRET_KEY=
JWT_SECRET_KEY=

MYSQL_HOST=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_DB=
MYSQL_PORT=

CORREO=
BREVO_API_KEY= (Asegurate de tener una cuenta creada y una api key valida para ti)

FRONTEND_URL=

COOKIE_HTTPONLY=
COOKIE_SECURE=
COOKIE_SAMESITE=
``

BREVO_API_KEY=
CORREO=

DEBUG=
```

### Requisitos

Para ejecutar este proyecto necesitas:

- **Python >= 3.11**
- **MySQL** (local o en la nube)

Paquetes incluidos en `requirements.txt`:

- Django
- djangorestframework
- django-cors-headers
- mysqlclient
- PyJWT
- python-dotenv
- sib-api-v3-sdk
- gunicorn

---

### Arquitectura y consideraciones técnicas

- Backend desarrollado con **Django Rest Framework**.
- Acceso directo a base de datos mediante:
  - `django.db.connection`
  - Cursores SQL (`cursor()`).
- Separación lógica mediante aplicaciones:
  - `animals`
  - `adminsystem`
  - `authsystem`
- Validación exhaustiva de datos mediante **serializers**.
- Arquitectura orientada a **API REST** consumida por clientes externos.


## Instalación

1. **Clona el repositorio**  
   Ejecuta el siguiente comando en tu terminal:
   ```bash
   git clone https://github.com/DavidKal29/ZOODEX-BACKEND.git
   cd ZOODEX-BACKEND

2. **Crea un entorno virtual** (opcional pero recomendado):
   ```bash
   python -m venv env
   source env/bin/activate    # Linux/Mac
   env\Scripts\activate       # Windows

3. **Instala las dependencias** 
   ```bash
   pip install -r requeriments.txt


4. **Ejectua la aplicacion** 
   ```bash
    python manage.py runserver
   ```

5. **Abre el navegador** 
   Ve a http://127.0.0.1:8000 para acceder a la aplicación.
