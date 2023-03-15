# kubec-cmd

## Info
Manage and rotate Kubernetes configuration files in the .kube folder with efficient backups and changes.

## Program overview

kubec-cmd aims to help users rotate and manage Kubernetes configuration files in the `.kube` folder. The code is divided into several Swift files, which work together to achieve this functionality:

1. **main.swift**: This is the entry point of the program, where the instructions for the user are printed, the command line arguments are processed using the `ArgsController()` function, and the configuration files in the `.kube` folder are listed. Finally, the `SearchFiles(target: String)` function is called with the desired configuration file suffix.

2. **ArgsManager.swift**: This file contains the `ArgsController()` function, which processes the command line arguments to obtain the desired configuration file suffix. If the "-t" argument is found and there is at least one additional argument, the function returns the provided suffix; otherwise, it returns an empty string.

3. **Dirhelper.swift**: This file contains the `PrintInstructions()` function, which is responsible for printing the usage instructions for the `kubec-cmd` program.

4. **FilesManager.swift**: This file contains several functions related to file and directory management in the context of rotating Kubernetes configuration files in the `.kube` folder. These functions perform the following actions:

   a. Create a backup directory for the configuration files (`CreateBackUpDirectory()`).
   
   b. Make a backup of the existing configuration files (`Makebackup()`).
   
   c. Remove the current configuration file (`Clean()`).
   
   d. Change the current configuration file to the configuration file with the provided `_target` suffix (`SwitcherConfig()`).

This command copies the `config_remote` file into the `.kube` folder and sets it as the active configuration file.

**Note**: Make sure you have the `config_main`, `config_local`, `config_remote`, etc., files in the `.kube` folder before running the commands above.

## How to use

Assuming you have the following files in `.kube`:

- `./kube/config_main`
- `./kube/config_repo`

To set the `config_repo` file as the active configuration, you can use the following command:

```bash
kubec-cmd -t repo
```

This will search for the file:
./kube/config_repo


And set it as the active configuration file used by kubectl.

In summary,  kubec-cmd allows users to easily switch between different Kubernetes configuration files, making the configuration file rotation process more efficient and secure.