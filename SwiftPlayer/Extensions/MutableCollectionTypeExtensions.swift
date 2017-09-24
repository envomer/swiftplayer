//
//  MutableCollectionTypeExtensions.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Foundation

//extension MutableCollection where Index == Int {
//    
//    mutating func shuffleInPlace() {
//        if count < 2 { return }
//        
////        for (var i = 0; i < count -1; i += 1) {
////            let j = Int(arc4random_uniform(UInt32(count - i))) + 1
////            
////            guard i != j else { continue }
////            swap(&self[i], &self[j])
////        }
//        
//        let max = Int(count.toIntMax())
//        
////        for var i in stride(from: 0, to: count - 1, by: 1) {
//        for i in 0 ..< (count - 1) {
//            let j = Int(arc4random_uniform((count - i))) + 1
//        
//            guard i != j else { continue }
//            swap(&self[i], &self[j])
//        }
//        
//    }
//    
//}


//extension MutableCollection {
//    /// Shuffle the elements of `self` in-place.
//    mutating func shuffleInPlace() {
//        // empty and single-element collections don't shuffle
//        if count < 2 { return }
//        
//        for i in indices.dropLast() {
//            let diff = distance(from: i, to: endIndex)
//            let j = index(i, offsetBy: numericCast(arc4random_uniform(numericCast(diff))))
//            swapAt(i, j)
//        }
//    }
//}


extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}
