//
//  ListItemModel.swift
//  TravelBook
//
//  Created by Onur Bilke on 7.03.2025.
//

import Foundation

struct ListItemModel: Codable {
    let id : String?
    let title : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
    }
}
