//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit
import Foundation


class SensorDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var SensorsDataTableView: UITableView!
    var listOfSensorsData = [SensorData]()
    var sensor: Sensor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = sensor?.form
        
        if let safeIdSensor = sensor?.id{
            let url = "http://api.gios.gov.pl/pjp-api/rest/data/getData/\(safeIdSensor)"
            LoadSensorsData(url:url)
            print("sensor id: ",safeIdSensor)
        }else{
            print("sensor null error")
        }

        SensorsDataTableView.delegate = self
        SensorsDataTableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
           if let safeIdSensor = sensor?.id{
               let url = "http://api.gios.gov.pl/pjp-api/rest/data/getData/\(safeIdSensor)"
               LoadSensorsData(url:url)
               print("sensor id: ",safeIdSensor)
           }else{
               print("sensor null error")
           }
           
        SensorsDataTableView.reloadData()
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            if listOfSensorsData.count > 0{
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
        return listOfSensorsData.count
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(listOfSensorsData[indexPath.row].id!)
    }*/
    
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
      
      DispatchQueue.main.async {
       self.SensorsDataTableView.reloadData()
      }
      
     }
    }
    
    

    

}
