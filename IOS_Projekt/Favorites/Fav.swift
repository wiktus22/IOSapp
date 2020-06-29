//
//  Fav.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 29/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
//

import UIKit

class Fav: NSObject, NSCoding {
    
    var favID: Int?
    var favName: String?
    
    init(json: [String: Any]) {
        self.favID = json["id"] as? Int
        self.favName = json["name"] as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.favID, forKey: "id")
        aCoder.encode(self.favName, forKey: "name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.favID = aDecoder.decodeObject(forKey: "id") as? Int
        self.favName = aDecoder.decodeObject(forKey: "name") as? String
    }
    

}
