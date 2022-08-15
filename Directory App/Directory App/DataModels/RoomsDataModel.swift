//
//  RoomsDataModel.swift
//  Directory App
//
//  Created by Kacper Cichosz on 06/08/2022.
//

import Foundation

struct RoomsDataModel: Codable {
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String
}
