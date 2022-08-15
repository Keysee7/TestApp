//
//  PeopleListViewModel.swift
//  Directory App
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import Foundation

class PeopleListViewModel: ViewModel, ViewModelProtocol {
    var peopleData: [PeopleDataModel]? {
        didSet {
            self.update?(.reload)
        }
    }
    var filteredPeople: [PeopleDataModel]? {
        didSet {
            self.update?(.reload)
        }
    }

    var update: ((PeopleListViewModel.UpdateType) -> Void)?
    enum UpdateType {
        case reload
    }
    
    var error: ((PeopleListViewModel.ErrorType) -> Void)?
    enum ErrorType {
        case canNotProcessData
    }
    
    /// Method to download the people data using the NetworkManager and APi Endpoint key 'people'
    func downloadPeopleData() {
        NetworkManager().downloadData(classType: [PeopleDataModel].self,
                                      settingsKey: Constants.Networking.NetworkingAPIKey,
                                      substitution: APIEndpoints.people.rawValue) { [weak self] peopleData, _, error in
            guard error == nil else {
                self?.error?(.canNotProcessData)
                return
            }
            
            self?.filteredPeople = peopleData
            self?.peopleData = peopleData
        }
    }
}
