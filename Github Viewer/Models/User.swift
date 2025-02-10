//
//  User.swift
//  Github Viewer
//
//  Created by Matheus Franceschini on 08/02/25.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatar_url: String?
}
