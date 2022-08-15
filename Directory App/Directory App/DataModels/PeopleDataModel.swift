//
//  PeopleDataModel.swift
//  Directory App
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import Foundation
import UIKit

// MARK: - PeopleDataModel
struct PeopleDataModel: Codable, Equatable {
    static func == (lhs: PeopleDataModel, rhs: PeopleDataModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let createdAt, firstName: String
    let avatar: String
    let lastName, email, jobtitle, favouriteColor: String
    let id: String
    let data: DataClass?
    let to, fromName: String?
    var image: UIImage { if let url = URL(string: avatar),
                            let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
        return image
    }
        return Constants.People.imagePlaceholder
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let title, body, id, toID: String
    let fromID, meetingid: String

    enum CodingKeys: String, CodingKey {
        case title, body, id
        case toID = "toId"
        case fromID = "fromId"
        case meetingid
    }
}

typealias People = [PeopleDataModel]
