//
//  KubeConfigList.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 28/07/23.
//

import Foundation

func listfilesinpath () -> [String]
{
    let fileManager = FileManager.default
    let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: kubeconfig.path.description)!
    var ConfigFound = [String]()
    for file in enumerator {
        if let file = file as? String {
            if file.contains(configsuffix) {
                if !file.contains("bk") && !file.contains(".back") && file.contains(configsuffix) {
                ConfigFound.append(file)
                }
            }
        }
    }
    return ConfigFound
}
