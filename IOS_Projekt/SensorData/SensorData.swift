//
//  SensorData.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 25/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
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
