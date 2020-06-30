//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit

class SensorData: NSObject {
 
 var date: String?
 var value: Double?
 
 init(date: String, value: Double) {
  self.date = date
  self.value = value
 }
 
}
