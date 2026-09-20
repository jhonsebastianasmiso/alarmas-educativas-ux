# Guías de Diseño y Estilo para alarmas_educativas

1. **Diseño Pixel-Perfect**: Toda pantalla o widget debe seguir estrictamente las maquetas entregadas (generalmente de Figma). Revisa detalladamente espaciados, colores, fuentes y alineación.
2. **Estética Apple (iOS)**: El proyecto utiliza un diseño inspirado en iOS. Los colores principales deben respetar esta línea (por ejemplo, azul Apple `#007AFF`, gris claro para fondos `#F2F2F7`, botones tipo pastilla (pill-shape)).
3. **Componentes Reutilizables**: ANTES de crear un nuevo componente desde cero, SIEMPRE verifica la carpeta `lib/shared/widgets/`. 
   - Usa `AppleButton` para botones principales responsivos.
   - Usa `AppleFormGroup` y `AppleFormField` para agrupar campos de texto estilo Apple.
   - Usa `WebLayout` para todas las pantallas principales de forma que queden centradas y limitadas (máximo 600px de ancho) en pantallas web o grandes.
4. **Responsividad**: Usa `LayoutBuilder` y `WebLayout` para asegurar que el contenido se ve impecable tanto en web como en móvil. No arrincones el contenido en resoluciones grandes.
