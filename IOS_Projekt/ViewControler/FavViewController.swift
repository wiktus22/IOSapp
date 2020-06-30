//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TVStationsFav: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TVStationsFav.delegate = self
        TVStationsFav.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        TVStationsFav.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavStation"{
            let destVC = segue.destination as! SensorsViewController
            destVC.station = sender as? Station
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
            if Defaults.listofFav.count > 0{
                tableView.backgroundView = nil
                return 1
                
            }else{
                let noDataLabel: UILabel = UILabel()
                noDataLabel.text = "No favorites yet? Add some in stations section."
                noDataLabel.textAlignment = NSTextAlignment.center
                tableView.backgroundView = noDataLabel
                tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                return 0
            }
                

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Defaults.listofFav.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationid = Defaults.listofFav[indexPath.row]
        performSegue(withIdentifier: "FavStation", sender: stationid)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FavStation:TVCFavorites = (tableView.dequeueReusableCell(withIdentifier: "FavStation", for: indexPath) as! TVCFavorites)
        FavStation.setStationFav(station: Defaults.listofFav[indexPath.row])
        return FavStation
    }
    
    
    
    @IBAction func FavRemove(_ sender: Any) {
     
     guard let button = sender as? UIButton else {
      return
     }
     
     guard let cell = button.superview?.superview as? UITableViewCell else {
      return
     }
     
     guard let indexPath = TVStationsFav.indexPath(for: cell) else {
      return
     }
        // create the alert
    let alert = UIAlertController(title: "Favorites", message: "Would you like remove this station from Favorites", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
    alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: { action in
    Defaults.listofFav.remove(at: indexPath.row)
    print("usunieto")
        self.TVStationsFav.reloadData()
        
            
    }))
        
        // show the alert
    self.present(alert, animated: true, completion: nil)

     TVStationsFav.reloadData()
    }

}
