//
//  EnemyLossesCell.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 09.07.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class EnemyLossesCell: UITableViewCell {
    
    let mainView = ViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.shadowColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0).cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    
    static let identifire = "EnemyLossesCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "EnemyLossesCell", bundle: nil)
    }
}
