# WFW - Alarmas Educativas UX

Este proyecto es un prototipo interactivo (MVP) desarrollado en **Flutter** para el proyecto de **UX Research y Design** en la Maestría en Ingeniería de Software de la Universidad de los Andes. 

El objetivo de la aplicación es explorar soluciones para la organización de actividades a través de alarmas contextualizadas (reuniones, estudio, medicamentos, etc.), descartando por completo el enfoque tradicional de "alarmas para despertarse".

---

## 🌐 Pruebas en Web

La versión web del prototipo ya se encuentra desplegada y lista para pruebas de usuario. Puedes acceder a ella desde cualquier navegador:

**URL Pública:** [https://alarmas-educativas-ux.vercel.app/](https://alarmas-educativas-ux.vercel.app/)

> **Nota para las pruebas Web:**
> No es necesario instalar nada. Solo ingresa al enlace, navega por el flujo de escritorio y evalúa la experiencia de usuario. Alternativamente, también tienes la opción de instalar Flutter, descargar el proyecto y compilarlo para Chrome de forma local usando `flutter run -d chrome`.

---

## 📱 Pruebas en Móvil (y ejecución local)

Para probar la experiencia nativa en dispositivos móviles o correr el proyecto localmente en tu máquina para validar el código y las interfaces, sigue estos pasos al pie de la letra.

### Requisitos Previos

Para ejecutar la aplicación nativamente en tu entorno local, asegúrate de cumplir con los siguientes requerimientos:
1. Tener instalado el **Flutter SDK** (versión estable más reciente recomendada). [Guía de Instalación Oficial](https://docs.flutter.dev/get-started/install).
2. Contar con un editor de código compatible (ej. **VS Code** con la extensión de Flutter, o **Android Studio**).
3. (Para pruebas móviles) Tener configurado y abierto un **emulador de Android**, un **simulador de iOS**, o un **dispositivo físico** conectado por USB/Wi-Fi en modo desarrollador.

### Paso a Paso para la Instalación y Ejecución

1. **Clonar el Repositorio:**
   Abre tu terminal de preferencia y ejecuta:
   ```bash
   git clone https://github.com/jhonsebastianasmiso/alarmas-educativas-ux.git
   ```

2. **Ingresar al directorio:**
   ```bash
   cd alarmas-educativas-ux
   ```

3. **Verificar el entorno de Flutter:**
   Es buena práctica asegurarse de que Flutter reconoce el dispositivo/emulador que tienes abierto:
   ```bash
   flutter doctor
   flutter devices
   ```

4. **Instalar Dependencias:**
   Descarga todos los paquetes necesarios declarados en el `pubspec.yaml`:
   ```bash
   flutter pub get
   ```

5. **Lanzar la Aplicación:**
   Finalmente, corre la aplicación. Si tienes múltiples dispositivos conectados, Flutter te pedirá seleccionar uno.
   ```bash
   flutter run
   ```

> **Arquitectura Multipantalla:**
> El proyecto detecta automáticamente la plataforma en la que se está ejecutando. Si se compila y ejecuta en un simulador/celular Android o iOS, mostrará directamente el **flujo nativo móvil**. Si decides ejecutarlo en Chrome (`flutter run -d chrome`), redirigirá automáticamente al **layout de escritorio (web)**.
> 
> **Descarga Rápida (Android):**
> De momento, puedes instalar el APK de prueba en Android desde el siguiente enlace:
> [Descargar APK (Próximamente)](#)

> **Nota Crítica sobre las Pruebas Móviles:**
> Para validar correctamente la experiencia de usuario móvil, es **estrictamente necesario** que la aplicación se corra en un celular (físico o simulado) con resoluciones móviles convencionales. Esto permitirá que la interacción con los menús inferiores tipo Apple, los modales con difuminado y los gestos de deslizamiento (*swipe*) en las tarjetas se rendericen y se experimenten de manera realista y *pixel-perfect*.

---

## 🎨 Aspectos Destacados del Diseño
- **Estilo Apple (iOS):** El diseño busca un acabado *pixel-perfect* basado en los lineamientos de Apple, empleando difuminados, botones tipo pastilla y esquinas redondeadas.
- **Responsividad:** El layout se adapta automáticamente para no perder legibilidad en pantallas anchas, manteniendo el contenido centrado y accesible.
- **Validación de Push Notifications:** Para probar el flujo interactivo de la notificación push estilo iOS, simplemente da clic en el botón inferior de **Actualizar / Sincronizar**. Podrás expandir la notificación, seleccionar '5 minutos más' o 'Estudiar', y experimentar el flujo completo hasta finalizar la tarea.
