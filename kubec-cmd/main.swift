//
//  main.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 08/11/22.
//

import Foundation


let configsuffix = "config_"
let kubeconfigDir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube").appendingPathComponent("config")
let kubeconfig = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube")

PrintInstructions()

let target = ArgsController()

if String(target).isEmpty
{
    print("Fail")
}



//get files in path
let fileManager = FileManager.default
let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: kubeconfig.path())!

// list of string
var ConfigFound = [String]()
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
SearchFiles()



//If exist file .kube/config
var exist = false
if FileManager.default.fileExists(atPath: kubeconfigDir.path) {
    exist = true
}

// delete file .kube/config
if exist{
    do {
        try FileManager.default.removeItem(at: kubeconfigDir)
    }
}


//copy file .kube/config_ to .kube/config
//If exist file .kube/config
var existTarget = false
if FileManager.default.fileExists(atPath: kubeconfigDir.path+"_"+target) {
    print("File exist")
    existTarget = true
}

if existTarget {
    let targetfile = "config_"+target
    let source = kubeconfig.appendingPathComponent(targetfile)
    let destination = kubeconfigDir
    do {
        try FileManager.default.copyItem(at: source, to: destination)
    } catch let error as NSError {
        print("Ooops! Something went wrong: \(error)")
    }
    print("Completed ✅")
} else
{
    print("Target no exist ❌ " + target )
}

