//
//  ViewController.swift
//  Venture
//
//  Created by Kelly Ochikubo on 4/28/16.
//  Copyright © 2016 Kelly Ochikubo. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

var places : [Place] = [
    //    Place(placeID: "ChIJ7-jW2eHZ3IAR7KhyG8Unu24", lat: 33.7924581,lng: -117.8512582, name: "Chapman University"),
    //    Place(placeID: "ChIJ0dAWlODZ3IARblvc5-1oJEY", lat: 33.7908901, lng: -117.8534305, name: "Rutabegorz")
]

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, Indexable {
    
    var mapView : GMSMapView!
    var placePicker : GMSPlacePicker!
    var placesClient : GMSPlacesClient?
    var locationManager : CLLocationManager!
    private var userLocation: CLLocation = CLLocation()
    var myLocation : CLLocation!
    var latitude : Double!
    var longitude : Double!
    var radius : Int!
    
    var index: Int = 0
    let SETTINGS_ID : String = "settings_nav"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        placesClient = GMSPlacesClient()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
    
    // Zooms map to current location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        myLocation = location
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        let camera = GMSCameraPosition.cameraWithLatitude(latitude, longitude: longitude, zoom: 13)
        mapView.animateToCameraPosition(camera)
        
        if myLocation != nil {
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    @IBAction func venturePressed(sender: AnyObject) {
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        radius = userDefaults.objectForKey("search_radius") as? Int
        
        var URL : NSURL
        //var HIKE_URL : NSURL
        if radius != nil {
            URL = NSURL(string: GoogleAPIWrapper.createRestaurantsURL(latitude, longitude: longitude, radius: radius))!
            //HIKE_URL = NSURL(string: GoogleAPIWrapper.createHikesURL(latitude, longitude: longitude, radius: radius))!
        } else {
            URL = NSURL(string: GoogleAPIWrapper.createRestaurantsURL(latitude, longitude: longitude, radius: 2))!
            //HIKE_URL = NSURL(string: GoogleAPIWrapper.createHikesURL(latitude, longitude: longitude, radius: 3000))!
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(URL) { (data, request, error) -> Void in
            
            if let e = error
            {
                print(e)
            }
            else
            {
                let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                let resultsNode = json?["results"]
                
                var i = 0
                var name : String = ""
                var lat : Double = 0
                var lng : Double = 0
                var placeID : String = ""
                var rating : Double = 0
                
                //NSThread.sleepForTimeInterval(1)
                self.mapView.clear()
                places.removeAll()
                
                while i < 20 {
                    name = resultsNode![i]["name"] as! String
                    lat = resultsNode![i]["geometry"]!!["location"]!!["lat"] as! Double
                    lng = resultsNode![i]["geometry"]!!["location"]!!["lng"] as! Double
                    placeID = resultsNode![i]["place_id"] as! String
                    rating = 4.0//(resultsNode![i]["rating"] as? Double)!
                    let place = Place(placeID: placeID, lat: lat, lng: lng, name: name, rating: rating)
                    places.append(place)
                    
                    i+=1
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //self.tempLabel.text = String(temp)
                    for place in places {
                        
                        //let position = CLLocationCoordinate2DMake(place.lat, place.lng)
                        //let marker = GMSMarker(position: position)
                        let marker = PlaceMarker(place: place)
                        marker.title = place.name
                        //marker.snippet = "\(place.rating)/5 stars"
                        marker.icon = UIImage(named: "restaurant")
                        marker.map = self.mapView
                    }
                })
            }
            
            
        }
        
        task.resume()
        
    }
    
    override func loadView() {
        mapView = GMSMapView()
        mapView.myLocationEnabled = true
        mapView.delegate = self
        self.view = mapView
    }
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        let placeMarker : PlaceMarker = marker as! PlaceMarker
        
        let alertController = UIAlertController(
            title: "Add \(placeMarker.place.name) to itinerary?",
            message: nil,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            // ...
        }
        
        let okayAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            
            itinerary.append(placeMarker.place)
            placeMarker.map = nil
        }
        
        alertController.addAction(okayAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    func mapView(mapView: GMSMapView, didLongPressInfoWindowOfMarker marker: GMSMarker) {
        
    }
    
    func getPlacesList() -> [Place] {
        return places
    }
    
    @IBAction func settingsPressed(sender: AnyObject) {
        let navVC = self.storyboard!.instantiateViewControllerWithIdentifier(SETTINGS_ID)
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
}



