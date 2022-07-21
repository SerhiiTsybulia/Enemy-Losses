//
//  LossesViewController.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 19.07.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class LossesViewController: UIViewController {

    @IBOutlet weak var lossesCount: UILabel?
    @IBOutlet weak var optionalPersonnel: UILabel!
    @IBOutlet weak var pow: UILabel?
    
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 59/255.0, green: 99/255.0, blue: 71/255.0, alpha: 1.0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func backBtnCliked() {
        navigationController?.popViewController(animated: true)
    }
}
