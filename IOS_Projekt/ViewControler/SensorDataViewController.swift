//
//  SensorDataViewController.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 25/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
//

import UIKit

class SensorDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var SensorsDataTableView: UITableView!
    var listOfSensorsData = [SensorData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://api.gios.gov.pl/pjp-api/rest/data/getData/92"
        LoadSensorsData(url:url)

        SensorsDataTableView.delegate = self
        SensorsDataTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfSensorsData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(listOfSensorsData[indexPath.row].id!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let SensorDataRecord:TVCSensorsData = (tableView.dequeueReusableCell(withIdentifier: "SensorDataRecord", for: indexPath) as! TVCSensorsData)
    SensorDataRecord.setSensorsData(sensorData: listOfSensorsData[indexPath.row])
        return SensorDataRecord
    }
    
    func LoadSensorsData(url:String) {
     
     DispatchQueue.global().async {
      
      guard let appURL = URL(string:url) else {
       print("error 1")
       return
      }
      
      guard let data = try? Data(contentsOf:appURL) else {
       print("error 2")
       return
      }
      
      guard let sensorsData = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
       print("error 3")
       return
      }
      
      guard let values = sensorsData["values"] as? [[String:Any]] else {
       print("error 4")
       return
      }
      
      for value in values {
       if let date = value["date"] as? String,
        let value = value["value"] as? Double {
        self.listOfSensorsData.append(SensorData(date: date, value: value))
       }
      }
      
      /*if let ids = sensor["id"] as? Int,
      let param = sensor["param"] as? [String:Any],
      let paramName = param["paramName"] as? String,
      let form = param["paramFormula"] as? String{
      self.listOfSensors.append(Sensor(name: paramName, id: ids, form: form))
      print("tak", paramName, form)
      }*/
      
      
      DispatchQueue.main.async {
       self.SensorsDataTableView.reloadData()
      }
      
     }
    }
    
    

    

}
