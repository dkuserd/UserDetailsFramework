//
//  Street.swift
//  UserDetailsFramework
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import Foundation
struct Street : Codable {
    let number : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case number = "number"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

