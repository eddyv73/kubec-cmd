//
//  ArgsManager.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 25/11/22.
//

import Foundation




func ArgsController () -> String{
    
    var target = ""
    let arguments = CommandLine.arguments

    if arguments.contains("-t") && arguments.count > 2
    {
        let targetfile = arguments[2]
        target = targetfile
        print("Argument 1 ↪︎ ",arguments[1])
        print("Argument 2 ↪︎ ",arguments[2])
        print("Target found ➥",targetfile)
    }
    return target
}
