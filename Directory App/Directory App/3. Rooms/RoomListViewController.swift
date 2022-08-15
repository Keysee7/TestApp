//
//  RoomListViewController.swift
//  Directory App
//
//  Created by Kacper Cichosz on 06/08/2022.
//

import UIKit

class RoomListViewController: ModelledViewController<RoomListViewModel> {
    @IBOutlet weak var roomsTableView: UITableView!
    @IBOutlet weak var occupancySegmentedControl: UISegmentedControl!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.downloadRoomData()
        self.title = Constants.RoomsTitle
        self.roomsTableView.register(UINib(nibName: "RoomListTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "RoomListTableViewCell")
    }
    
    override func updateView(_ type: RoomListViewModel.UpdateType) {
        switch type {
        case .reload:
            self.roomsTableView.reloadOnMainThread()
        }
    }
    
    override func handle(_ error: RoomListViewModel.ErrorType) {
        switch error {
        case .canNotProcessData:
            Alerts().showAlert(title: Constants.Alerts.RoomsAlertTitle,
                               message: Constants.Alerts.AlertMessage,
                               viewController: self)
        }
    }
    
    @IBAction func occupancyValueChanged() {
        switch self.occupancySegmentedControl.selectedSegmentIndex {
        case 0:
            self.viewModel.allRooms()
        case 1:
            self.viewModel.freeRooms()
        default:
            self.viewModel.allRooms()
        }
    }
}

// MARK: - UITableViewDataSource
extension RoomListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredRooms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomListTableViewCell", for: indexPath) as! RoomListTableViewCell
        if let room = self.viewModel.filteredRooms?[indexPath.row] {
            cell.setupUI(room: room)
        }
        return cell
    }
}
