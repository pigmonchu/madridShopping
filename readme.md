# iOS Offline Madrid Shopping

El proyecto se llama OfflineShopping aunque el repo sea madridShopping. Creo que cubre todos los requisitos.

Para ejecutar, descargar y abrir el proyecto `OfflineShopping.xcodeproj` con XCode 8

###Tareas pendientes.

1. **Internacionalización**. Utilizar alguna forma más estandar para traducir los mensajes de descarga. Supongo que habrá librerías que lo hagan del mismo modo que en las apps web. Pero ya no me da tiempo. Me he ceñido al mínimo indispensable para cumplir con el requisito.
2. No tengo claro porque mantiene el texto del botón del menú inicial en inglés cuando hace la carga inicial.
3. La forma de almacenar el logo con un resize a 40x40 hace que me aparezca pixelado (por aquello de las pantallas retinas). Debería gestionar mejor esto, supongo que almacenando 40x40, 80x80 y 120x120 y seleccionando el icono en función de la resolución del dispositivo. Pero algo me falta porque lo he medio intentado con 120x120 y 0.3 de escala y no funciona. Tampoco tengo tiempo de investigarlo... se queda en tareas pendientes
4. También me falta el ocultar los mapPins mientras se carga el mapa y quizás, como dicen Jose y Erik guardar el mapa offline, por si no hay conexión.
5. Forzar el inicio por la página de lista de tiendas siempre que no se deba realizar la carga inicial, en lugar de tener que dar al botón. Se ha dejado así por ser un requisito.
