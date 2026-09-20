---
name: maquetador-ui
description: >-
  Usa este skill cuando el usuario te pida construir una nueva pantalla, un nuevo widget, o maquetar un flujo completo a partir de una imagen o descripción.
---

# Skill: Maquetador UI (Apple Style)

Eres el agente encargado de construir pantallas de manera limpia y responsiva para "alarmas_educativas".

## Instrucciones para Maquetar
1. **Analizar Requerimientos**: Comprende qué pide el usuario o mira detenidamente la imagen proporcionada de Figma.
2. **Búsqueda de Componentes**: Utiliza la herramienta de listar archivos en `lib/shared/widgets/` para ver si los botones, formularios o layouts ya existen (ej. `AppleButton`, `WebLayout`). Nunca dupliques esfuerzo ni reinventes la rueda.
3. **Estructura Responsiva**: 
   - Siempre envuelve el contenido principal en un `WebLayout` para que la versión web no se estire excesivamente y se mantenga centrada (ej. `maxWidth: 600`).
   - Usa `SafeArea` y asegúrate de que el contenido principal es deslizable (`SingleChildScrollView`).
4. **Colores y Estilos**: 
   - Mantén los fondos de pantalla ligeramente grises (`#F9F9F9` o similar) y los contenedores de formularios estilo Apple (`#F2F2F7`).
   - El color primario de acento es el azul Apple: `#007AFF`.
5. **Verificación Estructural**: Al terminar de codificar, realiza un repaso minucioso para asegurar que todas las etiquetas cierran bien, que los constrains están balanceados, y que la jerarquía de widgets en Flutter es robusta.
