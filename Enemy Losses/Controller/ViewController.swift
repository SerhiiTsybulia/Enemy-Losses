//
//  ViewController.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//

import UIKit

class ViewController: UIViewController {

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
    @IBOutlet weak private var vehiclesAndFuelTanksBtn: UIButton!
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
    @IBAction private func aircraftBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let aircraftStr: String
      
        if let aircraftCount = model.equipment?.aircraft {
            aircraftStr = "\(aircraftCount)"
        } else {
            aircraftStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = aircraftStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func helicopterBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let helicopterStr: String
      
        if let helicopterCount = model.equipment?.helicopter {
            helicopterStr = "\(helicopterCount)"
        } else {
            helicopterStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = helicopterStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func tankBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let tankStr: String
      
        if let tankCount = model.equipment?.tank {
            tankStr = "\(tankCount)"
        } else {
            tankStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = tankStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func apcBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let apcStr: String
      
        if let apcCount = model.equipment?.apc {
            apcStr = "\(apcCount)"
        } else {
            apcStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = apcStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func fieldArtilleryBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let fieldArtilleryStr: String
      
        if let fieldArtilleryCount = model.equipment?.fieldArtillery {
            fieldArtilleryStr = "\(fieldArtilleryCount)"
        } else {
            fieldArtilleryStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = fieldArtilleryStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func mrlBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let mrlStr: String
      
        if let mrlCount = model.equipment?.mrl {
            mrlStr = "\(mrlCount)"
        } else {
            mrlStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = mrlStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func militaryAutoBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let militaryAutoStr: String
      
        if let militaryAutoCount = model.equipment?.militaryAuto {
            militaryAutoStr = "\(militaryAutoCount)"
        } else {
            militaryAutoStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = militaryAutoStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func fuelTankBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let fuelTankStr: String
      
        if let fuelTankCount = model.equipment?.fuelTank {
            fuelTankStr = "\(fuelTankCount)"
        } else {
            fuelTankStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = fuelTankStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func droneBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let droneStr: String
      
        if let droneCount = model.equipment?.drone {
            droneStr = "\(droneCount)"
        } else {
            droneStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = droneStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func navalShipBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let navalShipStr: String
      
        if let navalShipCount = model.equipment?.navalShip {
            navalShipStr = "\(navalShipCount)"
        } else {
            navalShipStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = navalShipStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func antiAircraftWarfareBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let antiAircraftWarfareStr: String
      
        if let antiAircraftWarfareCount = model.equipment?.antiAircraftWarfare {
            antiAircraftWarfareStr = "\(antiAircraftWarfareCount)"
        } else {
            antiAircraftWarfareStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = antiAircraftWarfareStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func specialEquipmnetBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let specialEquipmnetStr: String
      
        if let specialEquipmnetCount = model.equipment?.specialEquipment {
            specialEquipmnetStr = "\(specialEquipmnetCount)"
        } else {
            specialEquipmnetStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = specialEquipmnetStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func mobileSRBMSystemBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let mobileSRBMSystemStr: String
      
        if let mobileSRBMSystemCount = model.equipment?.mobileSRBMSystem {
            mobileSRBMSystemStr = "\(mobileSRBMSystemCount)"
        } else {
            mobileSRBMSystemStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = mobileSRBMSystemStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func vehiclesAndFuelTanksBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let vehiclesAndFuelTanksStr: String
      
        if let vehiclesAndFuelTanksCount = model.equipment?.vehiclesAndFuelTanks {
            vehiclesAndFuelTanksStr = "\(vehiclesAndFuelTanksCount)"
        } else {
            vehiclesAndFuelTanksStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = vehiclesAndFuelTanksStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
    @IBAction private func cruiseMissilesBtnCliked() {
        guard let model = pickedDayLossesModel else {
            return
        }
        
        let cruiseMissilesStr: String
      
        if let cruiseMissilesCount = model.equipment?.cruiseMissiles {
            cruiseMissilesStr = "\(cruiseMissilesCount)"
        } else {
            cruiseMissilesStr = "0"
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LossesVC") as! LossesViewController
        vc.loadView()
        vc.lossesCount?.text = cruiseMissilesStr
        vc.optionalPersonnel.text = ""
        vc.pow?.text = ""
        navigationController?.pushViewController(vc, animated:  true)
    }
}

