//
//  main.swift
//  mcwd
//
//  Created by Fredrik Åberg on 2022-12-16.
//

import Foundation

import AppKit

let frontAppPid = NSWorkspace.shared.frontmostApplication!.processIdentifier
let lsof = Process()


let pipe = Pipe()

lsof.executableURL = URL(fileURLWithPath: "/usr/sbin/lsof")

lsof.arguments = ["-a", "-p", String(frontAppPid), "-d", "cwd", "-Fn"]

lsof.standardOutput = pipe

let sed = Process()
sed.executableURL = URL(fileURLWithPath: "/usr/bin/sed")
sed.arguments = ["-e", "1,2d" ,"-e", "s/^.//"]
sed.standardInput = pipe

try lsof.run()
try sed.run()
sed.waitUntilExit()

