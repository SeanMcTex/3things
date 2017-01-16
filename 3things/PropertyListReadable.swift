//
//  PropertyListReadable.swift
//  3things
//
//  Created by Sean Mc Mains on 1/15/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

protocol PropertyListReadable {
    func propertyListRepresentation() -> NSDictionary
    init(propertyListRepresentation:NSDictionary)
}

