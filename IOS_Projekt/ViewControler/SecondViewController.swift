//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var TableViewStations: UITableView!
	var listOfStations = [Station]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        TableViewStations.delegate = self
		TableViewStations.dataSource = self
	}
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        ApiCall()
        TableViewStations.reloadData()
    }
    
    func ApiCall() {
        let url = "http://api.gios.gov.pl/pjp-api/rest/station/findAll"
        LoadStations(url:url)
    }
	
  
    @IBAction func ButtonAdd(_ sender: UIButton) {
		
		guard let cell = sender.superview?.superview as? UITableViewCell else {
			return
		}
		
		guard let indexPath = TableViewStations.indexPath(for: cell) else {
			return
		}
		
		// create the alert
		let alert = UIAlertController(title: "Favorites", message: "Would you like to add this station to Favorites", preferredStyle: UIAlertController.Style.alert)
		
		// add the actions (buttons)
		alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
		alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: { action in
			
			print("Dodaj do ulubionych")
			Defaults.listofFav.append(self.listOfStations[indexPath.row])
			
		}))
		
		// show the alert
		self.present(alert, animated: true, completion: nil)
		
	}
	//Funkcja wywołująca przekazanie danych
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "StationIdSegue" {
			let destVC = segue.destination as! SensorsViewController
			destVC.station = sender as? Station
		}
	}
    
    func numberOfSections(in tableView: UITableView) -> Int {
            if listOfStations.count > 0{
                tableView.backgroundView = nil
                return 1
                
            }else{
                let noDataLabel: UILabel = UILabel()
                noDataLabel.text = "No Data! Check your internet connection."
                noDataLabel.textAlignment = NSTextAlignment.center
                tableView.backgroundView = noDataLabel
                tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                return 0
            }
    }
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listOfStations.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let stationid = listOfStations[indexPath.row]
		performSegue(withIdentifier: "StationIdSegue", sender: stationid)
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let StationRecord:TVCStations = (tableView.dequeueReusableCell(withIdentifier: "StationRecord", for: indexPath) as! TVCStations)
		StationRecord.setStation(station: listOfStations[indexPath.row])
		return StationRecord
	}
	
	
	func LoadStations(url:String) {
		
		DispatchQueue.global().async {
			
			guard let appURL = URL(string:url) else {
				print("error")
				return
			}
			
			guard let data = try? Data(contentsOf:appURL) else {
				print("error")
				return
			}
			
			guard let stations = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]] else {
				print("error")
				return
			}
			
			for station in stations {
				
				if let name = station["stationName"] as? String,
					let id = station["id"] as? Int {
					self.listOfStations.append(Station(name: name, id: id))
					
				}
				//Narazie nie używane przyda sie do wyszukiwarki
				/*if let city = station["city"] as? [String:Any],
					let name = city["name"] as? String,
					let id = city["id"] as? Int {
					
					//print("Miasto", id, name)
					
				}*/
				DispatchQueue.main.async {
					self.TableViewStations.reloadData()
				}
				
			}
			
		}
	}
	
	
	
}

