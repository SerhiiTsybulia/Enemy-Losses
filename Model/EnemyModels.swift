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

struct EquipmentModelDto: Codable {
    let date: String
    let day, aircraft, helicopter, tank: Int
    let apc, fieldArtillery, mrl, militaryAuto: Int
    let fuelTank, drone, navalShip, antiAircraftWarfare: Int

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
    }
}

// MARK: - Personnel model

struct PersonnelModelDto: Codable {
    let date: String
    let day, personnel: Int
    let welcomePersonnel: String
    let pow: Int

    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case welcomePersonnel = "personnel*"
        case pow = "POW"
    }
}
