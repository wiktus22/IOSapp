//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit

class Station: Codable {
    
    var name: String?
    var id: Int?
     
    init(name:String,id:Int) {
        self.name=name
        self.id=id
    }
}

