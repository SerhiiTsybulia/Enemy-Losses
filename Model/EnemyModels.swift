//
//  EnemyModels.swift
//  Enemy Losses
//
//  Created by Sergei Tsybulya on 05.07.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Equipment model

struct EquipmentModelDto: Codable{
    let date: String
    let day: Int
    let aircraft: Int?
    let helicopter: Int?
    let tank: Int?
    let apc: Int?
    let fieldArtillery: Int?
    let mrl: Int?
    let militaryAuto: Int?
    let fuelTank: Int?
    let drone: Int?
    let navalShip: Int?
    let antiAircraftWarfare: Int?
    let specialEquipment: Int?
    let mobileSRBMSystem: Int?
    let vehiclesAndFuelTanks: Int?
    let cruiseMissiles: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            date = try container.decode(String.self, forKey: .date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let realDate = dateFormatter.date(from: date)
            print(realDate)
            day = Self.tryParseInt(container, key: .day) ?? -1
            aircraft = Self.tryParseInt(container, key: .aircraft)
            helicopter = Self.tryParseInt(container, key: .helicopter)
            tank = Self.tryParseInt(container, key: .tank)
            apc = Self.tryParseInt(container, key: .apc)
            fieldArtillery = Self.tryParseInt(container, key: .fieldArtillery)
            mrl = Self.tryParseInt(container, key: .mrl)
            militaryAuto = Self.tryParseInt(container, key: .militaryAuto)
            fuelTank = Self.tryParseInt(container, key: .fuelTank)
            drone = Self.tryParseInt(container, key: .drone)
            navalShip = Self.tryParseInt(container, key: .navalShip)
            antiAircraftWarfare = Self.tryParseInt(container, key: .antiAircraftWarfare)
            specialEquipment = Self.tryParseInt(container, key: .specialEquipment)
            mobileSRBMSystem = Self.tryParseInt(container, key: .mobileSRBMSystem)
            vehiclesAndFuelTanks = Self.tryParseInt(container, key: .vehiclesAndFuelTanks)
            cruiseMissiles = Self.tryParseInt(container, key: .cruiseMissiles)
        } catch {
            print("We have error here: \(error)")
            throw error
        }
    }
    
    static func tryParseInt(_ container: KeyedDecodingContainer<EquipmentModelDto.CodingKeys>, key: CodingKeys) -> Int? {
        if let intValue = try? container.decode(Int.self, forKey: key) {
            return intValue
        } else if let intString = try? container.decode(String.self, forKey: key), let intValue = Int(intString) {
            return intValue
        } else {
            return nil
        }
    }
}

// MARK: - Personnel model

struct PersonnelModelDto: Codable {
    let date: String
    let day, personnel: Int
    let optionalPersonnel: String
    let pow: Int
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case optionalPersonnel = "personnel*"
        case pow = "POW"
    }
}
