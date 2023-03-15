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
    
    if let targetIndex = arguments.firstIndex(of: "-t"), arguments.count > targetIndex + 1 {
        let targetFile = arguments[targetIndex + 1]
        args.target = targetFile
        print("Argument 1 ↪︎ ", arguments[targetIndex])
        print("Argument 2 ↪︎ ", arguments[targetIndex + 1])
        print("Target found ➥", targetFile)
    }
    
    if let contextIndex = arguments.firstIndex(of: "-c"), arguments.count > contextIndex + 1 {
        let context = arguments[contextIndex + 1]
        args.context = context
        print("Argument 3 ↪︎ ", arguments[contextIndex])
        print("Argument 4 ↪︎ ", arguments[contextIndex + 1])
        print("Context found ➥", context)
    }
    
    return args
}
