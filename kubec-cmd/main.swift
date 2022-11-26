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

SearchFiles(target: target)




