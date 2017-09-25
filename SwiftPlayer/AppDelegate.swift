//
//  AppDelegate.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import MediaKeyTap


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let popover = NSPopover()
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var eventMonitor: EventMonitor?
    var mediaKeyTap: MediaKeyTap?
    var manager: PlayerManager?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        statusItem.title = ""
        manager = PlayerManager.sharedManager
        
        if let button = statusItem.button {
            button.image = NSImage(named: "Star")
            button.action = #selector(togglePopover)
        }
        
        // generate status item controller dynamic
        popover.contentViewController = StatusItemViewController.loadFromNib()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: { (event) -> () in
            if self.popover.isShown {
                self.closePopover(sender: event)
            }
        })
        
        mediaKeyTap = MediaKeyTap(delegate: self)
        mediaKeyTap?.start()
        
//        GlobalHotKey.register()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // MARK: - Helpers
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
        
        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }


}

extension AppDelegate: MediaKeyTapDelegate {
    func handle(mediaKey: MediaKey, event: KeyEvent) {
        switch mediaKey {
        case .playPause:
            print("Play/pause pressed")
            manager?.play()
        case .previous:
            print("Previous pressed")
            manager?.rewind()
        case .rewind:
            print("Rewind pressed")
            manager?.rewind()
        case .next:
            print("Next pressed")
            manager?.next()
        case .fastForward:
            print("Fast Forward pressed")
            manager?.next()
        }
    }
}
