//
//  Repository.swift
//  Github Viewer
//
//  Created by Matheus Franceschini on 07/02/25.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let language: String?
}
