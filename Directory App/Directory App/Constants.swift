//
//  Constants.swift
//  Directory App
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import Foundation
import UIKit

enum APIEndpoints: String {
    case people
    case rooms
}

struct Constants {
    struct Networking {
        static let NetworkingAPIKey = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/"
    }
    struct Alerts {
        static let PeopleAlertTitle = "Error loading People"
        static let RoomsAlertTitle = "Error loading Rooms"
        static let AlertMessage = "Please try again"
    }
    struct Font {
        static let TitleFont = "HelveticaNeue"
        static let TitleFontSize = 30.0
    }
    struct People {
        static let NameTitle = "Name:"
        static let EmailTitle = "Email:"
        static let JobTitleTitle = "Job Title:"
        static let ImageCornerRadius = 15.0
        static let ImageBorderWidth = 5.0
        static let DetailsViewCornerRadius = 15.0
        static let AccountAddedString = "Account added: "
        static let imagePlaceholder = UIImage(named: "imageProfilePlaceholder")!
        
    }
    struct Rooms {
        static let RoomMaxOccupanyString = "Room max occupancy is:"
        static let RoomIsEmptyString = "Room is empty"
        static let RoomIsFullString = "Room is full"
        static let RoomIDString = "Room ID:"
    }
    static let MainTitle = "Main Menu"
    static let PeopleTitle = "People"
    static let RoomsTitle = "Rooms"
    static let MainBrandColour = UIColor(hexString: "#C40202")
    static let SearchBarHeight: CGFloat = 44.0
}
