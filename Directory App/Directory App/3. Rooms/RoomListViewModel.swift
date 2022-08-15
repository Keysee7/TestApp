//
//  RoomListViewModel.swift
//  Directory App
//
//  Created by Kacper Cichosz on 06/08/2022.
//

import UIKit

class RoomListViewModel: ViewModel, ViewModelProtocol {
    var rooms: [RoomsDataModel]?
    var filteredRooms: [RoomsDataModel]? {
        didSet {
            self.update?(.reload)
        }
    }
    
    var update: ((RoomListViewModel.UpdateType) -> Void)?
    enum UpdateType {
        case reload
    }
    var error: ((RoomListViewModel.ErrorType) -> Void)?
    enum ErrorType {
        case canNotProcessData
    }
    
    /// Method to download the room data using the NetworkManager and APi Endpoint key 'rooms'
    func downloadRoomData() {
        NetworkManager().downloadData(classType: [RoomsDataModel].self,
                                      settingsKey: Constants.Networking.NetworkingAPIKey,
                                      substitution: APIEndpoints.rooms.rawValue) { [weak self] roomsData, _, error in
            guard error == nil else {
                self?.error?(.canNotProcessData)
                return
            }
            
            self?.filteredRooms = roomsData
            self?.rooms = roomsData
            self?.update?(.reload)
        }
    }
    
    func freeRooms() {
        self.filteredRooms = self.filteredRooms?.filter {!$0.isOccupied}
    }
    
    func allRooms() {
        self.filteredRooms = self.rooms
    }
}
