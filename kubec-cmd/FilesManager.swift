//  FilesManager.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 25/11/22.
//

import Foundation

func SearchFiles(target: String, context: String)  {
    _target = target
    _context = context
    CreateBackUpDirectory()
    Makebackup()
    getconfig()
    Clean()
    SwitcherConfig()
    
}

func CreateBackUpDirectory(){
    //create directory
    do {
        try FileManager.default.createDirectory(at: dirbk, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        print(error.localizedDescription);
    }
}
func getconfig ()
{
    // list of string
    //Select confifiles
    for file in enumerator {
        if let file = file as? String {
            if file.contains(configsuffix) {
                if !file.contains("bk") && !file.contains(".back")
                {
                    ConfigFound.append(file)
                }
            }
        }
    }
}
func Makebackup() {
    //date forma date + time
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy_HH-mm-ss"
    let result = formatter.string(from: date)

    //copy files .kube to .kube/bk and append _date + time
    for file in ConfigFound {
        let source = kubeconfig.appendingPathComponent(file)
        let destination = dirbk.appendingPathComponent(file).appendingPathExtension(result)
        do {
            try FileManager.default.copyItem(at: source, to: destination)
        } catch _ as NSError {
            print("Error on Create backup ⚠️")
        }
    }
    
}

func Clean () {
    //If exist file .kube/config
    var exist = false
    if FileManager.default.fileExists(atPath: kubeconfigDir.path) {
        exist = true
    }

    // delete file .kube/config
    if exist{
        do {
            try FileManager.default.removeItem(at: kubeconfigDir)
        } catch _ as NSError {
            print("Error on Create backup ⚠️")
        }
    }
}

//copy file .kube/config_ to .kube/config
//If exist file .kube/config

func SwitcherConfig() {
    var existTarget = false
    if FileManager.default.fileExists(atPath: kubeconfigDir.path+"_"+_target) {
        print("File exist ⛴️")
        existTarget = true
    }

    if existTarget {
        let targetfile = configsuffix+_target
        let source = kubeconfig.appendingPathComponent(targetfile)
        let destination = kubeconfigDir
        do {
            try FileManager.default.copyItem(at: source, to: destination)
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        print("Completed ✅")

        // Cambia el contexto si se especificó
        if !_context.isEmpty {
            let changeContextCommand = "config use-context \(_context)"
            let task = Process()
            task.launchPath = "/opt/homebrew/bin/kubectl"
            task.arguments = [changeContextCommand]
            task.launch()
            task.waitUntilExit()
            print("Context switched to: \(_context)")
        }
    } else
    {
        print("Target no exist ❌ " + _target )
    }
}

