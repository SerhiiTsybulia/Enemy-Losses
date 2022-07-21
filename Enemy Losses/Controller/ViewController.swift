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
    
    private var dayLossesModelsMap: [Date: DayLossesModel]?
    private var pickedDayLossesModel: DayLossesModel?
    
    @IBOutlet weak private var dateList: UIDatePicker!
    @IBOutlet weak private var personnelBtn: UIButton!
    @IBOutlet weak private var aircraftBtn: UIButton!
    @IBOutlet weak private var helicopterBtn: UIButton!
    @IBOutlet weak private var tankBtn: UIButton!
    @IBOutlet weak private var apcBtn: UIButton!
    @IBOutlet weak private var fieldArtilleryBtn: UIButton!
    @IBOutlet weak private var mrlBtn: UIButton!
    @IBOutlet weak private var militaryAutoBtn: UIButton!
    @IBOutlet weak private var fuelTankBtn: UIButton!
    @IBOutlet weak private var droneBtn: UIButton!
    @IBOutlet weak private var navalShipBtn: UIButton!
    @IBOutlet weak private var antiAircraftWarfareBtn: UIButton!
    @IBOutlet weak private var specialEquipmnetBtn: UIButton!
    @IBOutlet weak private var mobileSRBMSystemBtn: UIButton!
    @IBOutlet weak private var veiclesAndFuelTanksBtn: UIButton!
    @IBOutlet weak private var cruiseMissilesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateList.datePickerMode = .date
        dateList.addTarget(self, action: #selector(datePicked), for: .valueChanged)
    
        apiService.getModels { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    let alertController = UIAlertController(title: "Error", message: "Loading data failure: \(error)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                case .success(let dayLossesModels):
                    var allDates: Set<Date> = .init()
                    dayLossesModels.forEach {
                        allDates.insert($0.date)
                    }
                    guard !allDates.isEmpty else { return }
                    let sortedDates = Array(allDates).sorted(by: <)
                    let minDate = sortedDates.first ?? .init()
                    let maxDate = sortedDates.last ?? .init()
                    self?.dateList.minimumDate = minDate
                    self?.dateList.maximumDate = maxDate
                    self?.dateList.date = minDate
                    var map: [Date: DayLossesModel] = [:]
                    dayLossesModels.forEach {
                        map[$0.date] = $0
                    }
                    self?.dayLossesModelsMap = map
                    self?.pickedDayLossesModel = map[minDate]
                }
            }
        }
    }
    
    @IBAction private func datePicked(_ sender: UIDatePicker) {
        let pickedDate = sender.date
        guard let pickedModel = dayLossesModelsMap?[pickedDate] else { return }
        loadModelToUI(pickedModel)
    }
    
    private func loadModelToUI(_ pickedModel: DayLossesModel) {
        pickedDayLossesModel = pickedModel
    }
    
    @IBAction private func personnelBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let personnelStr: String
        let optionalPersonnelStr: String
        let powStr: String
        
        if let personnelCount = model.personal?.personnel {
            personnelStr = "\(personnelCount)"
        } else {
            personnelStr = ""
        }
        if let optionalPersonnelValue = model.personal?.optionalPersonnel {
            optionalPersonnelStr = "\(optionalPersonnelValue)".uppercased()
        } else {
            optionalPersonnelStr = ""
        }
        if let powCount = model.personal?.pow {
            powStr = "POW: \(powCount)"
        } else {
            powStr = ""
        }
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = personnelStr
        vc.optionalPersonnel.text = optionalPersonnelStr
        vc.pow?.text = powStr
        navigationController?.pushViewController(vc, animated:  true)
    }
}
