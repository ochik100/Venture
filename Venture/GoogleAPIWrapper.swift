//
//  GoogleAPIWrapper.swift
//  Venture
//
//  Created by Kelly Ochikubo on 5/16/16.
//  Copyright © 2016 Kelly Ochikubo. All rights reserved.
//

import GoogleMaps

class GoogleAPIWrapper {
    
    class func createRestaurantsURL(latitude : Double, longitude : Double, radius : Int) -> String {
        
        let url = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        let location = "location=\(latitude),\(longitude)"
        let meters = Float(radius) * 1609.34
        let radius = "radius=\(meters)"
        //let key = "key=AIzaSyCayaRqjEUtbK6Q4jbH_5Ht3kuL6HU1epg"
        let key = "key=AIzaSyClaKgQDlhpvVdrHvKkmkN7WFBCnY65UUQ"
        let query = "query=restaurants"
        return "\(url)?\(key)&\(query)&\(location)&\(radius)"
        
    }
    
    class func createHikesURL(latitude : Double, longitude : Double, radius : Int) -> String {
        
        let url = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        let location = "location=\(latitude),\(longitude)"
        let meters = Float(radius) * 1609.34
        let radius = "radius=\(meters)"
        //let key = "key=AIzaSyCayaRqjEUtbK6Q4jbH_5Ht3kuL6HU1epg"
        let key = "key=AIzaSyClaKgQDlhpvVdrHvKkmkN7WFBCnY65UUQ"
        let query = "query=hike"
        return "\(url)?\(key)&\(query)&\(location)&\(radius)"
        
    }
}

extension String {
    
    mutating func setType(type : String) {
        let _type = "&type=\(type)"
        return self.appendContentsOf(_type)
    }
    
}
