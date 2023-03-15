# kubec-cmd

# Info
Administra y rota archivos de configuración de Kubernetes en la carpeta .kube con copias de seguridad y cambios eficientes

## Descripción general del programa

kubec-cmd tiene como objetivo ayudar a los usuarios a rotar y administrar archivos de configuración de Kubernetes en la carpeta `.kube`. El código se divide en varios archivos Swift, que trabajan juntos para lograr esta funcionalidad:

1. **main.swift**: Este es el punto de entrada del programa, donde se imprimen las instrucciones para el usuario, se procesan los argumentos de la línea de comandos utilizando la función `ArgsController()` y se enumeran los archivos de configuración en la carpeta `.kube`. Finalmente, se llama a la función `SearchFiles(target: String)` con el sufijo del archivo de configuración deseado.

2. **ArgsManager.swift**: Este archivo contiene la función `ArgsController()`, que procesa los argumentos de la línea de comandos para obtener el sufijo del archivo de configuración deseado. Si se encuentra el argumento "-t" y hay al menos un argumento adicional, la función devuelve el sufijo proporcionado; de lo contrario, devuelve una cadena vacía.

3. **Dirhelper.swift**: Este archivo contiene la función `PrintInstructions()`, que se encarga de imprimir las instrucciones de uso para el programa `kubec-cmd`.

4. **FilesManager.swift**: Este archivo contiene varias funciones relacionadas con la gestión de archivos y directorios en el contexto de rotar archivos de configuración de Kubernetes en la carpeta `.kube`. Estas funciones realizan las siguientes acciones:

   a. Crear un directorio de respaldo para los archivos de configuración (`CreateBackUpDirectory()`).
   
   b. Realizar una copia de seguridad de los archivos de configuración existentes (`Makebackup()`).
   
   c. Eliminar el archivo de configuración actual (`Clean()`).
   
   d. Cambiar el archivo de configuración actual al archivo de configuración con el sufijo `_target` proporcionado (`SwitcherConfig()`).

Este comando copia el archivo `config_remote` en la carpeta `.kube` y lo establece como el archivo de configuración activo.

**Nota**: Asegúrate de tener los archivos `config_main`, `config_local`, `config_remote`, etc., en la carpeta `.kube` antes de ejecutar los comandos anteriores.
Como usar

Suponiendo que tienes los siguientes archivos en `.kube`

./kube/config_main
./kube/config_repo

para establecer como repo el archivo en config, puedes utilizar el siguiente comando
```bash
 kubec-cmd -t repo
 ``` 
 esto buscara el archivo
 
./kube/config_repo

y lo establecera como el config el cual utiliza el kubectl
En resumen, este programa en Swift permite a los usuarios cambiar fácilmente entre diferentes archivos de configuración de Kubernetes, haciendo que el proceso de rotación de archivos de configuración sea más eficiente y seguro.
