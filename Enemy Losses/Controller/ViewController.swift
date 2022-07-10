//
//  ViewController.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var apiService: ApiServiceProtocol = ApiService()
    
    private var dayLossesModels: [DayLossesModel]?
    
    @IBOutlet weak private var table: UITableView!
    
    private lazy var header: Header? = {
        let header = Header.create()
        return header
    }()
    
    
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

        // MARK: - Regeister cells
        
        table.register(EnemyLossesCell.nib(), forCellReuseIdentifier: EnemyLossesCell.identifire)
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = true
        table.allowsMultipleSelection = false
        table.backgroundColor = UIColor(red: 59/255.0, green: 99/255.0, blue: 71/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 59/255.0, green: 99/255.0, blue: 71/255.0, alpha: 1.0)
        table.separatorColor = UIColor.white
        table.alwaysBounceVertical = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - UITableViewDataSource impl

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayLossesModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EnemyLossesCell.identifire, for: indexPath) as? EnemyLossesCell
        precondition(cell != nil, "cell must be not nil")
        return cell ?? .init(frame: .zero)
    }
}


// MARK: - UITableViewDelegate impl

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200
    }
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        80
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndex = indexPath.row
//    }
}
    

