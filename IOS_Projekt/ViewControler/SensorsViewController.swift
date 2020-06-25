//
//  SensorsViewController.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 25/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
//

import UIKit

class SensorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var SensorsTableView: UITableView!
    var listOfSensors = [Sensor]()
    //var StationID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //let url = "http://api.gios.gov.pl/pjp-api/rest/data/getData/92"
        //let url = "http://api.gios.gov.pl/pjp-api/rest/station/findAll"
        let url = "http://api.gios.gov.pl/pjp-api/rest/station/sensors/114"
        LoadSensors(url:url)
        
        SensorsTableView.delegate = self
        SensorsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return listOfSensors.count
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(listOfSensors[indexPath.row].id!)
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let SensorRecord:TVCSensors = (tableView.dequeueReusableCell(withIdentifier: "SensorRecord", for: indexPath) as! TVCSensors)
    SensorRecord.setSensors(sensor: listOfSensors[indexPath.row])
        return SensorRecord
    }
    
    func LoadSensors(url:String) {
        
        DispatchQueue.global().async {
            
            guard let appURL = URL(string:url) else {
                print("error")
                return
            }
            
            guard let data = try? Data(contentsOf:appURL) else {
                print("error")
                return
            }
            
            guard let sensors = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]] else {
                print("error")
                return
            }
            
            for sensor in sensors {
             
             print("--")
                /*if let ids = sensor["stationId"] as? Int{
                    print("działa", ids)
                }*/
                
                if let ids = sensor["id"] as? Int,
                let param = sensor["param"] as? [String:Any],
                let paramName = param["paramName"] as? String,
                let form = param["paramFormula"] as? String{
                    self.listOfSensors.append(Sensor(name: paramName, id: ids, form: form))
                    print("tak", paramName, form)
                }
                
               // self.listOfSensors.append(Sensor(name: paramName, id: ids, form: form))
             
            DispatchQueue.main.async {
                self.SensorsTableView.reloadData()
                }
             
            }
            
        }
    }
}



