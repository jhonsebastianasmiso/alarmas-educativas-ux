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

Para probar la experiencia nativa en dispositivos móviles o correr el proyecto localmente, es necesario compilar la aplicación utilizando el SDK de Flutter.

### Requisitos Previos

1. Instalar [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Tener configurado un editor de código como VS Code o Android Studio.
3. Tener un simulador de iOS, emulador de Android, o un dispositivo físico conectado.

### Instrucciones de Instalación

1. Clona el repositorio en tu máquina local.
2. Abre la terminal en la raíz del proyecto.
3. Instala las dependencias del proyecto ejecutando:
   ```bash
   flutter pub get
   ```

### Ejecución

Para iniciar la aplicación, asegúrate de tener un dispositivo/emulador seleccionado y ejecuta:

```bash
flutter run
```

> **Arquitectura Multipantalla:**
> El proyecto detecta automáticamente la plataforma en la que se está ejecutando. Si se compila y ejecuta en Android o iOS, mostrará directamente el flujo nativo móvil. Si se ejecuta en Chrome o Web, redirigirá al layout de escritorio.
> 
> **Descarga Rápida (Android):**
> De momento, puedes instalar el APK de prueba en Android desde el siguiente enlace:
> [Descargar APK (Próximamente)](#)

> **Nota para las pruebas Móviles (Locales):**
> Durante las sesiones de validación con usuarios, la aplicación debe estar corriendo en un celular (físico o simulado) para que la interacción con los menús inferiores, los diálogos de estilo iOS y los gestos de deslizamiento se experimenten de manera realista.

---

## 🎨 Aspectos Destacados del Diseño
- **Estilo Apple (iOS):** El diseño busca un acabado *pixel-perfect* basado en los lineamientos de Apple, empleando difuminados, botones tipo pastilla y esquinas redondeadas.
- **Responsividad:** El layout se adapta automáticamente para no perder legibilidad en pantallas anchas, manteniendo el contenido centrado y accesible.
