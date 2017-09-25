//
//  MainWindowController.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 25/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        window?.titleVisibility = .hidden
        window?.titlebarAppearsTransparent = true
        
        let col = CGFloat(0.95)
        window?.backgroundColor = NSColor(calibratedRed: col, green: col, blue: col, alpha: 1)
    }
    
    func applicationDidFinishLaunching(aNotification: Notification) {
        print("doee")
    }

}
