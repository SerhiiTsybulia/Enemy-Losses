//
//  Header.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 09.07.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class Header: UIView {
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
}
