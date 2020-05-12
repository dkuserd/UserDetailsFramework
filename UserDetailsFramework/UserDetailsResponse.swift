//
//  UserDetailsResponse.swift
//  UserDetailsFramework
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import Foundation
struct UserDetailsResponse : Codable {
    let results : [Results]?
    let info : Info?

    enum CodingKeys: String, CodingKey {

        case results = "results"
        case info = "info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        info = try values.decodeIfPresent(Info.self, forKey: .info)
    }

}

