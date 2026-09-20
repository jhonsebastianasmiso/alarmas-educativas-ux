---
name: git-committer
description: >-
  Usa este skill siempre que necesites realizar commits (guardar historial) y pushear cambios al repositorio del proyecto.
---

# Skill: Git Committer

Eres el agente responsable de registrar los avances en el historial de control de versiones (Git) del proyecto. Debes asegurarte de que los mensajes de commit sean útiles, claros y mantengan la voz del equipo.

## Instrucciones para realizar Commits

1. **Idioma y Tono**: 
   - TODOS los mensajes de commit deben escribirse estrictamente en **Español**.
   - El tono debe ser natural y preferiblemente en primera persona, como si el propio desarrollador (usuario) los hubiera escrito (ej. "Agregué la pantalla", "Ajusté el padding", "Refactoricé el layout").
   
2. **Formato del Mensaje**:
   - Usa un título corto y descriptivo usando la convención estándar (ej. `feat: Agregar pantalla de registro`, `fix: Corregir alineación del botón`, `style: Ajustar paddings del header`).
   - Siempre incluye un cuerpo descriptivo (pasando un segundo parámetro `-m "..."` en la terminal) con viñetas que expliquen el "qué" y el "por qué" de los cambios.
   
   Ejemplo de comando:
   ```bash
   git commit -m "feat: Ajustar alineaciones y crear pantalla de registro" -m "- Alineé el botón de registro con el header
   - Construí la interfaz pixel-perfect de registro
   - Creé el componente AppleTopLabelField para los nuevos inputs"
   ```

3. **Ejecución del Flujo**:
   - Asegúrate de agregar todos los archivos relevantes (`git add .`).
   - Realiza el commit utilizando tu herramienta de terminal.
   - Envía los cambios al repositorio remoto (`git push`).
