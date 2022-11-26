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

var target = ""
let arguments = CommandLine.arguments

if arguments.contains("-t") && arguments.count > 2
{
    let targetfile = arguments[2]
    target = targetfile
    print("Argument 1: ",arguments[1])
    print("Argument 2: ",arguments[2])
    print("target found >>> ",targetfile)
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
    }
}


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

