//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit
import Foundation

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func DeleteAll(_ sender: Any) {
        
        // create the alert
        let alert = UIAlertController(title: "Delete Data", message: "Would you like to delete all your Favorites", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: { action in
            
            Defaults.listofFav.removeAll()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
