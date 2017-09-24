//
//  PlaylistViewController.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa

class PlaylistViewController: NSViewController {
    var strings = ["P1", "P2", "P3"]
    @IBOutlet weak var outlineView: NSOutlineView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        outlineView.dataSource = self
        outlineView.delegate = self
    }
    
    // MARK: - Helpers
    
    func isHeader(item: Any) -> Bool {
        return (item as? String) == "Library"
    }
}

extension PlaylistViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return 1
        }
        
        return strings.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return true
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return "Library"
        }
        
        return strings[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return item
    }
}

extension PlaylistViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if isHeader(item: item) {
            return outlineView.make(withIdentifier: "HeaderCell", owner: self)
        }
        
        let view = outlineView.make(withIdentifier: "DataCell", owner: self) as? NSTableCellView
        view?.textField?.stringValue = (item as? String)!
        return view
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        return !isHeader(item: item)
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
        return isHeader(item: item)
    }
}
