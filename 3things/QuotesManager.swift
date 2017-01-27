//
//  QuotesManager.swift
//  3things
//
//  Created by Sean Mc Mains on 1/27/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

private let quotesFileName = "ProductivityQuotes"
private let textKey = "quote"
private let attributionKey = "attribution"

struct QuotesManager {
    private let quotes: [Quote]
    
    init() {

        var quotes: [Quote] = []
        if let path = Bundle.main.path(forResource: quotesFileName, ofType: "plist"),
            let array = NSArray(contentsOfFile: path) as? [NSDictionary] {
            for element in array {
                if let text = element[ textKey ] as? String,
                    let attribution = element[ attributionKey ] as? String {
                    let quote = Quote(text: text, attribution: attribution)
                    quotes.append( quote )
                }
            }
            }
        self.quotes = quotes
    }
    
    func randomQuote() -> Quote? {
        return self.quotes.randomElement
    }
}
