//
//  TableViewControllerNotificacionesCell.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit

class TableViewControllerNotificacionesCell: UITableViewCell {
    
   
    @IBOutlet weak var NotificacionFecha: UILabel!
    @IBOutlet weak var NotificacionDescripcion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}