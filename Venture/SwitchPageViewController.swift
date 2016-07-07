//
//  SwitchPageViewController.swift
//  Venture
//
//  Created by Kelly Ochikubo on 4/28/16.
//  Copyright © 2016 Kelly Ochikubo. All rights reserved.
//

import UIKit

class SwitchPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let MAP_ID : String = "map_view"
    let LIST_ID : String = "list_view"
    let PLAN_ID : String = "plan_view"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let mapVC = self.storyboard!.instantiateViewControllerWithIdentifier(MAP_ID)
        self.setViewControllers([mapVC], direction: .Forward, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = (viewController as! Indexable).index
        
        switch currentIndex {
        case 0:
            return nil
        case 1:
            return self.storyboard!.instantiateViewControllerWithIdentifier(MAP_ID)
        case 2:
            return self.storyboard!.instantiateViewControllerWithIdentifier(PLAN_ID)
        default:
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = (viewController as! Indexable).index
        
        switch currentIndex {
        case 0:
            return self.storyboard!.instantiateViewControllerWithIdentifier(LIST_ID)
        case 1:
            return self.storyboard!.instantiateViewControllerWithIdentifier(PLAN_ID)
        case 2:
            return nil
        default:
            return nil
        }
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
