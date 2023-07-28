//
//  KubeConfigList.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 28/07/23.
//

import Foundation

func listfilesinpath () -> [String]
{
    let home = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube").path();
    let fileManager = FileManager.default
    let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: home)!
    var ConfigFound = [String]()
    for file in enumerator {
        if let file = file as? String {
            if file.contains(configsuffix) {
                if !file.contains("bk") && !file.contains(".back") && file.contains("config_") {
                ConfigFound.append(file)
                }
            }
        }
    }
    return ConfigFound
}
