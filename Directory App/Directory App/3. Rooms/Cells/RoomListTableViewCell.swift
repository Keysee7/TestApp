//
//  RoomListTableViewCell.swift
//  Directory App
//
//  Created by Kacper Cichosz on 06/08/2022.
//

import UIKit

class RoomListTableViewCell: UITableViewCell {
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var occupancyLabel: UILabel!
    @IBOutlet weak var isOccupiedLabel: UILabel!
    @IBOutlet weak var isOccupiedView: UIView!
    
    func setupUI(room: RoomsDataModel) {
        self.idView.madeRounded(borderWidth: Constants.People.ImageBorderWidth,
                                borderColor: Constants.MainBrandColour.cgColor)
        self.idLabel.text = room.id
        self.idLabel.textColor = Constants.MainBrandColour
        self.setupAccessability(room: room)
        self.occupancyLabel.text = "\(Constants.Rooms.RoomMaxOccupanyString) \(room.maxOccupancy)"
        self.isOccupiedLabel.text = room.isOccupied ? Constants.Rooms.RoomIsFullString : Constants.Rooms.RoomIsEmptyString
        self.isOccupiedView.backgroundColor = room.isOccupied ? .systemRed : .systemGreen
    }
    
    func setupAccessability(room: RoomsDataModel) {
        self.isAccessibilityElement = true
        self.idView.isAccessibilityElement = true
        self.idView.accessibilityLabel = "\(Constants.Rooms.RoomIDString) \(room.id)"
    }
}
