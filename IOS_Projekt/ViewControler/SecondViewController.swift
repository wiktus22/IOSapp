//
//  SecondViewController.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 25/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TableViewStations: UITableView!
    var listOfStations = [Station]()
    //var StationID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://api.gios.gov.pl/pjp-api/rest/station/findAll"
        LoadStations(url:url)
        
        TableViewStations.delegate = self
        TableViewStations.dataSource = self
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfStations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(listOfStations[indexPath.row].id!)
        //StationID = listOfStations[indexPath.row].id!
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
             
             print("--")
             
             if let name = station["stationName"] as? String,
              let id = station["id"] as? Int {
              
              print("Stacja", id, name)
              self.listOfStations.append(Station(name: name, id: id))
            
              
             }
             
             if let city = station["city"] as? [String:Any],
              let name = city["name"] as? String,
              let id = city["id"] as? Int {

              print("Miasto", id, name)

             }
            DispatchQueue.main.async {
                self.TableViewStations.reloadData()
                }
             
            }
            
        }
    }
    
    

}

