//
//  ApiService.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import Foundation


final class ApiService {
    
    // MARK: - Equipment losses request
    
    func requestEquipmentLosses(completionHandler: @escaping (Result<[EquipmentModelDto], Error>) -> Void) {
        let url = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            do {
                let equipmentLossesDto = try JSONDecoder().decode([EquipmentModelDto].self, from: data)
                completionHandler(.success(equipmentLossesDto))
            } catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
    // MARK: - Personnel losses request
    
    func requestPersonnelLosses(completionHandler: @escaping (Result<[PersonnelModelDto], Error>) -> Void) {
        let url = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            do {
                let personnelLossesDto = try JSONDecoder().decode([PersonnelModelDto].self, from: data)
                completionHandler(.success(personnelLossesDto))
            }
            catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
}

struct MyError: Error {
}
