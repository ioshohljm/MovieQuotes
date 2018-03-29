//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by Justin Hohl on 3/29/18.
//  Copyright © 2018 hohljm. All rights reserved.
//

import UIKit

class MovieQuote: NSObject {
    var quote: String
    var movie: String
    
    init(quote: String, movie: String){
        self.quote = quote
        self.movie = movie
    }
}
