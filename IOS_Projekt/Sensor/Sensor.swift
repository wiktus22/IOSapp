//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit

class Sensor {
    
    var name: String?
    var form: String?
    var id: Int?
     
    init(name: String, id: Int, form: String) {
        self.name = name
        self.id = id
        self.form = form
    }

}
