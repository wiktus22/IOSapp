//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import Foundation

struct Defaults {
	
	static var FAVKEY = "FAV-STATIONS"

	static var listofFav: [Station] {
		
		set {
		
			if let encoded = try? JSONEncoder().encode(newValue) {
				UserDefaults.standard.set(encoded, forKey: Defaults.FAVKEY)
			}
			
		}
		
		get {
			
			let object = UserDefaults.standard.object(forKey: Defaults.FAVKEY)
			
			if let data = object as? Data, let value = try? JSONDecoder().decode([Station].self, from: data) {
				return value
			}
			
			return []
			
		}
		
	}
	
}
