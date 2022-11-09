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

//copy target
let target = "main"

//let kubec = GetKubeconfig()
print("vanilla :::: ",kubeconfig)
print("vanilla + ::::::",kubeconfig.path())

//get files in path
let fileManager = FileManager.default
let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: kubeconfig.path())!

// list of string
var ConfigFound = [String]()
//Select confifiles
for file in enumerator {
    if let file = file as? String {
        if file.contains(configsuffix) {
            if !file.contains("bk")
            {
//                print("Config contains ::::file :: ",file)
                ConfigFound.append(file)
            }
            
        }
    }
}


//create directory
let dir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube").appendingPathComponent("bk")

do {
    try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
} catch let error as NSError {
    print(error.localizedDescription);
}


//date forma date + time
let date = Date()
let formatter = DateFormatter()
formatter.dateFormat = "dd-MM-yyyy_HH-mm-ss"
let result = formatter.string(from: date)


//copy files .kube to .kube/bk and append _date + time

for file in ConfigFound {
    let source = kubeconfig.appendingPathComponent(file)
    let destination = dir.appendingPathComponent(file).appendingPathExtension(result)
    do {
        try FileManager.default.copyItem(at: source, to: destination)
    } catch let error as NSError {
        print("Ooops! Something went wrong: \(error)")
    }
}

// delete file .kube/config
do {
    try FileManager.default.removeItem(at: kubeconfigDir)
} catch let error as NSError {
    print("Ooops! Something went wrong: \(error)")
}

//copy file .kube/config_ to .kube/config

let source = kubeconfig.appendingPathComponent("config_"+target)
let destination = kubeconfigDir
do {
    try FileManager.default.copyItem(at: source, to: destination)
} catch let error as NSError {
    print("Ooops! Something went wrong: \(error)")
}




