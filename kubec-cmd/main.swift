//  main.swift
//  kubec-cmd
//
//  Created by Eddy Wister on 08/11/22.
//

import Foundation

let configsuffix = "config_"
let kubeconfigDir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube").appendingPathComponent("config")
let kubeconfig = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube")
let dirbk = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube").appendingPathComponent("bk")
var _target = ""
var _context = ""
var ConfigFound = [String]()
let fileManager = FileManager.default
let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: kubeconfig.path())!


// Modified to handle both target and context arguments
let args = ArgsController()


