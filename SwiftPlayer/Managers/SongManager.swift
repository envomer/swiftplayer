//
//  SongManager.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Foundation
import iTunesLibrary
import RealmSwift

final class SongManager {
    
    func importSongs() throws -> [Song]? {
        do {
            let realm = try Realm()
            
            let library = try ITLibrary(apiVersion: "1.0")
            
            let allItems = library.allMediaItems 
            let songs = allItems.filter({ item -> Bool in
                return item.mediaKind == ITLibMediaItemMediaKind.kindSong
                    && item.location != nil
                    && item.locationType == ITLibMediaItemLocationType.file
            }).map { item -> Song in
                return Song(item: item)
            }
            
            try realm.write {
                realm.add(songs)
            }
            
            return songs
            
        } catch let error as NSError {
            print("error loading iTunesLibrary")
            throw error
        }
    }

}
