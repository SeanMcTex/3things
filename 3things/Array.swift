//
//  Array.swift
//  3things
//
//  Created by Sean Mc Mains on 1/27/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

extension Array {
    var randomElement: Element? {
        if self.count > 0 {
            let index = Int( arc4random_uniform( UInt32( count ) ) )
            return self[index]
        } else {
            return nil
        }
    }
}
