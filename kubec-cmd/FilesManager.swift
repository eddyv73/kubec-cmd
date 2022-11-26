//
//  FilesManager.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 25/11/22.
//

import Foundation


let dir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube").appendingPathComponent("bk")

func SearchFiles()  {
    CreateBackUpDirectory()
    Makebackup()
}

func CreateBackUpDirectory(){
    //create directory
    do {
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        print(error.localizedDescription);
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
        let destination = dir.appendingPathComponent(file).appendingPathExtension(result)
        do {
            try FileManager.default.copyItem(at: source, to: destination)
        } catch let error as NSError {
            print("Error on Create backup ⚠️")
        }
    }
    
}
