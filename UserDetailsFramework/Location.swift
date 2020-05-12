//
//  Location.swift
//  UserDetailsFramework
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import Foundation
struct Location : Codable {
    let street : Street?
    let city : String?
    let state : String?
    let country : String?
//    let postcode : String?
    let coordinates : Coordinates?
    let timezone : Timezone?

    enum CodingKeys: String, CodingKey {

        case street = "street"
        case city = "city"
        case state = "state"
        case country = "country"
//        case postcode = "postcode"
        case coordinates = "coordinates"
        case timezone = "timezone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decodeIfPresent(Street.self, forKey: .street)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
//        postcode = try values.decodeIfPresent(String.self, forKey: .postcode)
        coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        timezone = try values.decodeIfPresent(Timezone.self, forKey: .timezone)
    }

}

