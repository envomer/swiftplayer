//
//  CustomOutlineView.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 25.09.17.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa

class CustomOutlineView: NSOutlineView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        backgroundColor = NSColor.clear
    }
    
}
