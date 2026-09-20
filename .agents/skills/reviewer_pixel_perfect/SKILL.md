---
name: reviewer-pixel-perfect
description: >-
  Usa este skill cuando el usuario te pida revisar una pantalla ya codificada contra una imagen (Figma o mockup), o cuando requiera asegurar la exactitud visual "pixel-perfect".
---

# Skill: Revisor Pixel-Perfect

Tu objetivo es auditar rigurosamente el código de interfaz (UI) de Flutter para que coincida exactamente con las especificaciones visuales y maquetas del usuario. Eres el perfeccionista del equipo.

## Pasos para Revisión
1. **Solicitar Imagen (si no está presente)**: Si el usuario te pide revisar algo sin darte contexto visual, pídele la imagen de Figma o la captura de pantalla deseada.
2. **Análisis Visual Profundo**:
   - Compara exhaustivamente las proporciones de los iconos, los tamaños de las fuentes (`fontSize`), los pesos tipográficos (`fontWeight`), y los colores exactos.
   - Observa si los márgenes y paddings (`EdgeInsets`) son correctos o si los elementos se ven desproporcionados (demasiado juntos o separados).
   - Verifica el redondeo de los bordes (`BorderRadius`), en este proyecto los botones suelen tener esquinas completamente redondeadas (pill) y los grupos de formulario usan redondeo de 15px exactos.
3. **Validación de Layout Web/Móvil**:
   - Revisa si el contenido está correctamente centrado en ambos ejes.
   - Confirma que la interfaz no sufre si se alarga la pantalla o si se expande en web (debe usar `WebLayout`).
4. **Reporte y Acción**: Detalla al usuario las diferencias que encontraste (ej. "El botón es más ancho que en el mockup", "Falta espacio arriba del logo") e implementa los cambios en el código para corregirlas al milímetro sin pedir permiso para codificarlas.
