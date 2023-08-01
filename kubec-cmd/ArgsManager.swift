//  ArgsManager.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 25/11/22.
//

import Foundation

struct Args {
    var target: String = ""
    var context: String = ""
}

func ArgsController() -> Args {
    var args = Args()
    let arguments = CommandLine.arguments
//    if !arguments.contains("--list"){
//        print("lo tengo")
//    }
    if arguments.count == 1 && !arguments.contains("--list")
    {
        PrintInstructions()
        return args
    }
    if let targetIndex = arguments.firstIndex(of: "-t"), arguments.count > targetIndex + 1 {
        let targetFile = arguments[targetIndex + 1]
        args.target = targetFile
        //only for debug
//        print("Argument 1 ↪︎ ", arguments[targetIndex])
//        print("Argument 2 ↪︎ ", arguments[targetIndex + 1])
        print("Target found ➥", targetFile)
        SearchFiles(target: args.target, context: args.context)
    }
    else if arguments.contains("--list")
    {
        let files = listfilesinpath()
        print("List of files in path: ",kubeconfig.path.description)
        for file in files {
            print(file)
        }
    }
    else
    {
        print("No target file found")
        PrintInstructions()
    }
    
    return args
}




