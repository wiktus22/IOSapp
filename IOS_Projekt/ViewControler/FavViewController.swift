//
//  FavViewController.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 29/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
//

import UIKit

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TVStationsFav: UITableView!
    var listOfFav = [Station]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TVStationsFav.delegate = self
        TVStationsFav.dataSource = self
        
        //listOfFav.append(Station(name: "dupa",id: 12))
        
        let decodedData = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "favo") as! Data) as! [Fav]
        print("\(decodedData[0].favID)\(decodedData[0].favName)")
        
        var lenght = decodedData.count
        var count = 0
        
        if lenght>=count {
            self.listOfFav.append(Station(name: decodedData[count].favName!, id: decodedData[count].favID!))
            count+=1
            
        }
        
        
        // Do any additional setup after loading the view.
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFav.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationid = listOfFav[indexPath.row]
        //performSegue(withIdentifier: "StationIdSegue", sender: stationid)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FavStation:TVCFavorites = (tableView.dequeueReusableCell(withIdentifier: "FavStation", for: indexPath) as! TVCFavorites)
        FavStation.setStationFav(station: listOfFav[indexPath.row])
        return FavStation
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
