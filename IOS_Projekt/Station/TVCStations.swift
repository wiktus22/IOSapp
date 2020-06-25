//
//  TVCStations.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 25/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
//

import UIKit

class TVCStations: UITableViewCell {
    
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var StationName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setStation(station:Station){
        self.StationName.text = station.name
        self.ID.text = "\(station.id ?? 1)"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
