//
//  Place.swift
//  Venture
//
//  Created by Kelly Ochikubo on 5/16/16.
//  Copyright © 2016 Kelly Ochikubo. All rights reserved.
//

import Foundation

class Place {
    
    var placeID : String
    var lat : Double
    var lng : Double
    var name : String
    var rating : Double
    
    init(placeID : String, lat : Double, lng : Double, name : String, rating : Double) {
        self.placeID = placeID
        self.lat = lat
        self.lng = lng
        self.name = name
        self.rating = rating
    }
}