//
//  PlaceMarker.swift
//  Venture
//
//  Created by Kelly Ochikubo on 5/16/16.
//  Copyright © 2016 Kelly Ochikubo. All rights reserved.
//

import GoogleMaps

class PlaceMarker: GMSMarker {

    let place: Place

    init(place: Place) {
        self.place = place
        super.init()
        
        position = CLLocationCoordinate2DMake(place.lat, place.lng)
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
