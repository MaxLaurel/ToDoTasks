//
//  Main.swift
//  ToDoTasks
//
//  Created by Максим on 22.03.2024.
//

import UIKit

class Application: UIApplication {}

let application = Application.shared
let delegate = AppDelegate()
let scene = SceneDelegate()
application.delegate = delegate

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, NSStringFromClass(Application.self), NSStringFromClass(AppDelegate.self))


