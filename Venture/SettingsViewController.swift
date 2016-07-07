//
//  SettingsViewController.swift
//  Venture
//
//  Created by Kelly Ochikubo on 4/29/16.
//  Copyright © 2016 Kelly Ochikubo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var radius : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let storedRadius = userDefaults.objectForKey("search_radius")
        
        if let storedRadius = storedRadius {
            radiusSlider.setValue(storedRadius as! Float, animated: false)
            setRadiusLabelValue(storedRadius as! Int)
        } else {
            setRadiusLabelValue(Int(radiusSlider.value))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func radiusChanged(sender: AnyObject) {
        
        radius = Int(radiusSlider.value)
        setRadiusLabelValue(radius)
        
    }
    
    func setRadiusLabelValue(radius : Int) {
        let SEARCH_RADIUS = "Search Radius"
        let MILES = "miles"
        radiusLabel.text = "\(SEARCH_RADIUS): \(radius) \(MILES)"
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        
        userDefaults.setObject(radius, forKey: "search_radius")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
