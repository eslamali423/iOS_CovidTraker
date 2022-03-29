//
//  State.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import Foundation


struct StateListResponse : Codable {
    let data : [State]
}


struct State : Codable {
    let name : String
    let state_code : String
}
