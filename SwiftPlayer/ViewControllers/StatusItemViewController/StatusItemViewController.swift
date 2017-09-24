//
//  StatusItemViewController.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 25/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa

class StatusItemViewController: NSViewController {
    
    //
    class func loadFromNib() -> StatusItemViewController {
        let vc = NSStoryboard(name: "Main", bundle: nil)
            .instantiateController(withIdentifier: "StatusItemViewController") as! StatusItemViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
