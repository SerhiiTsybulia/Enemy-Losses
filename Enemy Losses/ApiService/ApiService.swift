//
//  ApiService.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import Foundation

typealias GetModelsCompletion = (Result<[DayLossesModel], MyError>) -> Void

// MARK: - ApiServiceProtocol -

protocol ApiServiceProtocol {
    func getModels(_ completion: @escaping GetModelsCompletion)
}

// MARK: - ApiService -

final class ApiService {
    
    // MARK: - Equipment losses request
    
    private func requestEquipmentLosses(completionHandler: @escaping (Result<[EquipmentModelDto], MyError>) -> Void) {
        let url = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.init(error)))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.allowsJSON5 = true
                let equipmentLossesDtos = try jsonDecoder.decode([EquipmentModelDto].self, from: data)
                completionHandler(.success(equipmentLossesDtos))
            } catch {
                completionHandler(.failure(.init(error)))
            }
        }).resume()
    }
    
    // MARK: - Personnel losses request
    
    private func requestPersonnelLosses(completionHandler: @escaping (Result<[PersonnelModelDto], MyError>) -> Void) {
        let url = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.init(error)))
                return
            }
            do {
                let personnelLossesDto = try JSONDecoder().decode([PersonnelModelDto].self, from: data)
                completionHandler(.success(personnelLossesDto))
            }
            catch {
                completionHandler(.failure(.init(error)))
            }
        }).resume()
    }
}

// MARK: - ApiServiceProtocol implementation -

extension ApiService: ApiServiceProtocol {
    func getModels(_ completion: @escaping (Result<[DayLossesModel], MyError>) -> Void) {
        var personalError: MyError?
        var personalModels: [PersonnelModelDto]?
        var equipmentError: MyError?
        var equipmentModels: [EquipmentModelDto]?
        
        let tryCompleteProcessing = {
            let personalRequestComplete = personalError != nil || personalModels != nil
            let equipmentRequestComplete = equipmentError != nil || equipmentModels != nil
            guard personalRequestComplete && equipmentRequestComplete else {
                return
            }
            
            if let anyError = personalError ?? equipmentError {
                completion(.failure(anyError))
            }
            
            fatalError("implement models marge")
        }
        
        requestPersonnelLosses {
            switch $0 {
            case .success(let models):
                personalModels = models
            case .failure(let error):
                personalError = error
            }
            tryCompleteProcessing()
        }
        
        requestEquipmentLosses {
            switch $0 {
            case .success(let models):
                equipmentModels = models
            case .failure(let error):
                equipmentError = error
            }
            tryCompleteProcessing()
        }
    }
}

// MARK: - MyError -

struct MyError: Error {
    let sourceError: Error?
    
    init(_ sourceError: Error?) {
        self.sourceError = sourceError
    }
}
