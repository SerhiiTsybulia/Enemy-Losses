//
//  ApiService.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import Foundation

// MARK: - API Service

final class ApiService {
    
    // MARK: - Equipment losses request
    
    private func requestEquipmentLosses(completionHandler: @escaping (Result<EquipmentModelDto, Error>) -> Void) {
        let url = "https://github.com/MacPaw/2022-Ukraine-Russia-War-Dataset/blob/main/data/russia_losses_equipment.json"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            do {
                let equipmentLossesDto = try JSONDecoder().decode(EquipmentModelDto.self, from: data)
                completionHandler(.success(equipmentLossesDto))
            } catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
    // MARK: - Personnel losses request
    
    private func requestPersonnelLosses(completionHandler: @escaping (Result<PersonnelModelDto, Error>) -> Void) {
        let url = "https://github.com/MacPaw/2022-Ukraine-Russia-War-Dataset/blob/main/data/russia_losses_personnel.json"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            do {
                let hourlyWeatherDto = try JSONDecoder().decode(PersonnelModelDto.self, from: data)
                completionHandler(.success(hourlyWeatherDto))
            }
            catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
}

struct MyError: Error {
}
