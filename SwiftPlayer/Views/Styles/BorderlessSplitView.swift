//
//  BorderlessSplitView.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 25.09.17.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa

class BorderlessSplitView: NSSplitView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override var dividerThickness:CGFloat {
        return 0.0
    }
    
}
