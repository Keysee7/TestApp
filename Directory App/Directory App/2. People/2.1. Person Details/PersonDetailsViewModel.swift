//
//  PersonDetailsViewModel.swift
//  Directory App
//
//  Created by Kacper Cichosz on 25/07/2022.
//

import Foundation
import UIKit


class PersonDetailsViewModel: ViewModel, ViewModelProtocol {
    var person: PeopleDataModel
    var people: [PeopleDataModel]
    var filteredPeople: [PeopleDataModel]?
    
    init (person: PeopleDataModel, people: [PeopleDataModel]) {
        self.person = person
        self.people = people
    }
    
    var update: ((PersonDetailsViewModel.UpdateType) -> Void)?
    enum UpdateType {
        case personDetails
        case searchPeople
    }
    
    var error: ((PersonDetailsViewModel.ErrorType) -> Void)?
    enum ErrorType {
    }
    
    /// Method to return the string with the date given by the createdAt from API
    func getDate() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        guard let date = formatter.date(from: self.person.createdAt),
              let day = Calendar.current.dateComponents([.day, .month, .year], from: date).day,
              let month = Calendar.current.dateComponents([.day, .month, .year], from: date).month,
              let year = Calendar.current.dateComponents([.day, .month, .year], from: date).year else {
            return ""
        }
        
        return "\(Constants.People.AccountAddedString)\(day).\(month).\(year)"
    }
}
