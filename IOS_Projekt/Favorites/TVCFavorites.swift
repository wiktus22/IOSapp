//
//  TVCFavorites.swift
//  IOS_Projekt
//
//  Created by Wiktor Zawadzki on 29/06/2020.
//  Copyright © 2020 Wiktor Zawadzki. All rights reserved.
//

import UIKit

class TVCFavorites: UITableViewCell {

    @IBOutlet weak var StationName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setStationFav(station:Station){
        self.StationName.text = station.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
