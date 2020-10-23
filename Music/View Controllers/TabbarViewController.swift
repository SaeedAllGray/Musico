//
//  TabbarViewController.swift
//  Music
//
//  Created by saeed on 3/27/20.
//  Copyright © 2020 saeed. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet var tabbar: UITabBar!
     var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabbar.selectedItem?.title == "Library" {
            counter = counter + 1
            if counter == 5 {
                easterEggAlert()
            counter = 0
            }
        } else {
            counter = 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func multipleTap(_ sender: UITabBarItem, event: UIEvent) {
        let touch: UITouch = event.allTouches!.first!
        if (touch.tapCount == 2) {
            // do action.
        }
    }
    func easterEggAlert() {
            let alertController = UIAlertController(title: "Another Easter Egg", message: "You are so clever. 😁", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.orange
            let okAction = UIAlertAction(title: "Yes, Here I am.", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)

            
        }
    
}
