//
//  Name.swift
//  UserDetailsFramework
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import Foundation
struct Name : Codable {
    let title : String?
    let first : String?
    let last : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case first = "first"
        case last = "last"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first = try values.decodeIfPresent(String.self, forKey: .first)
        last = try values.decodeIfPresent(String.self, forKey: .last)
    }

}

