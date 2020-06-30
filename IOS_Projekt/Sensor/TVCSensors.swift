//  IOS_Projekt Jakość powietrza
//  Politechnika Śląska 2020
//
//  Copyright © 2020 Maksymilian Wojciech, Wiktor Zawadzki. All rights reserved.
//

import UIKit

class TVCSensors: UITableViewCell {

    @IBOutlet weak var IDSensor: UILabel!
    @IBOutlet weak var ParamName: UILabel!
    @IBOutlet weak var Form: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSensors(sensor:Sensor){
        self.ParamName.text = sensor.name
        self.IDSensor.text = "\(sensor.id ?? 1)"
        self.Form.text = sensor.form
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
