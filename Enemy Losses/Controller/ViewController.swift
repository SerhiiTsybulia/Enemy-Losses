//
//  ViewController.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//

import UIKit

class ViewController: UIViewController {
    //red: 59/255.0, green: 99/255.0, blue: 71/255.0, alpha: 1.0
    private lazy var apiService: ApiServiceProtocol = ApiService()
    
    private var dayLossesModels: [DayLossesModel]?
    
    @IBOutlet weak private var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.getModels { [weak self] result in
            switch result {
            case .failure(let error):
                print("Request failed: \(error)")
                let alertController = UIAlertController(title: "Error", message: "Loading data failure: \(error)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            case .success(let dayLossesModels):
                print("Request result: \(dayLossesModels)")
                self?.dayLossesModels = dayLossesModels
                self?.table.reloadData()
            }
        }
    }
    
    private func showDatePicker() {
        let picker = UIDatePicker()
        
    }
}
