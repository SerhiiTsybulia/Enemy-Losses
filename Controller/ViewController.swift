//
//  ViewController.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        apiService.requestPersonnelLosses { result in
//            switch result {
//            case .failure(let error):
//                print("Request failed: \(error)")
//            case .success(let personalModelDto):
//                print("Request result: \(personalModelDto)")
//            }
//        }
        apiService.requestEquipmentLosses { result in
            switch result {
            case .failure(let error):
                print("Request failed: \(error)")
            case .success(let equipmentModelDto):
                print("Request result: \(equipmentModelDto)")
            }
        }
    }
}
