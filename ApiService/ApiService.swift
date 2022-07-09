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
                let jsonDecoder = JSONDecoder()
                jsonDecoder.allowsJSON5 = true
                let equipmentLossesDtos = try jsonDecoder.decode([EquipmentModelDto].self, from: data)
                completionHandler(.success(equipmentLossesDtos))
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

//func customParse(json: Data) -> EquipmentModelDto? {
//
//    JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
////    let json = JSONSerialization.jsonObject(with: json, options: .init())
////    guard let id = json["miliataryAuto"] (можно ли сюда через запятую прописать все пункты с NaN) as? Int else {
////        print("Couldn't convert miliataryAuto to an Int")
////        return nil
////    }
////    // TODO: parse the rest of the JSON...
////    return EquipmentModelDto(miliataryAuto: miliataryAuto)
//}
