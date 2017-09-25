//
//  CustomTableHeaderView.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 25/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa

class CustomTableHeaderView: NSTableHeaderView {
    
    override var allowsVibrancy: Bool {
        return false
    }

    override func awakeFromNib() {
        wantsLayer = true
        layer?.backgroundColor = NSColor(red: 37, green: 37, blue: 37, alpha: 1).cgColor
//        layer?.backgroundColor = NSColor.black.cgColor
    }
    
}
