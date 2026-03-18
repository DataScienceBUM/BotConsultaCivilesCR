# BotConsultaCivilesCR

BotConsultaCivilesCR es un conjunto de scripts en R diseñados para automatizar la consulta de información civil en Costa Rica utilizando Selenium (mediante RSelenium u otro cliente similar) y `rvest` para la extracción de datos (web scraping).

## Descripción

El proyecto facilita la interacción con un portal de consulta civil mediante el uso de un navegador controlado remotamente (Google Chrome). Permite realizar búsquedas por número de cédula y extraer automáticamente información detallada sobre:

- Datos personales (nombre completo, fecha y lugar de nacimiento, nacionalidad, estado de empadronamiento, etc.).
- Información de los padres.
- Hijos registrados.
- Matrimonios registrados y detalles del cónyuge.
- Lugar de votación.

## Archivos del Proyecto

- **`funciones.R`**: Contiene todas las funciones principales para interactuar con el navegador web, buscar cédulas, navegar entre paneles y extraer tablas o datos de texto de la página web.
- **`verificacionChromedriver.R`**: Script utilitario para verificar, descargar e instalar automáticamente la versión correcta de `chromedriver` compatible con tu versión local de Google Chrome.

## Requisitos

- **R** (versión reciente recomendada).
- Paquetes de R: `rvest`, `stringr`, `dplyr` (usualmente mediante `tidyverse`), y el cliente para controlar Selenium (por ejemplo, `RSelenium`).
- Google Chrome instalado en el sistema.
- **Chromedriver**: El script `verificacionChromedriver.R` te ayudará a configurar la versión adecuada.

## Configuración y Uso

1. **Configurar Chromedriver**: 
   Ejecuta el script `verificacionChromedriver.R`. *Nota:* Asegúrate de modificar la línea 11 del script para reemplazar `tuUsuario` por tu nombre de usuario real de Windows (`C:/Users/tuUsuario/AppData/Local/binman/binman_chromedriver/win32`).

2. **Cargar Funciones**:
   Ejecuta `source("funciones.R")` en tu entorno de R para cargar todas las funciones de automatización.

3. **Ejecución**:
   Inicia tu sesión de Selenium y utiliza la función `navegar(url)` para ingresar a la página correspondiente. Luego, puedes utilizar funciones como `buscarCedula("123456789")` para comenzar la extracción de datos.

## Advertencia Legal y Ética

Este proyecto ha sido creado con fines educativos y de automatización personal. El uso de web scraping y bots debe realizarse siempre respetando los términos de servicio, políticas de privacidad y los límites de peticiones (rate limits) de los sitios web consultados. El mal uso de esta herramienta es responsabilidad exclusiva del usuario.
