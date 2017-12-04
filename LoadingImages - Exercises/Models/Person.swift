//
//  Person.swift
//  LoadingImages - Exercises
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct Person: Codable {
    let results: [PersonDetails]
}
struct PersonDetails: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let dob: String
    let phone: String
    let cell: String
    let picture: ImageLinks?
}

struct ImageLinks: Codable {
    let large: String
    let thumbnail: String
}

struct LocationWrapper: Codable {
    let street: String
    let city: String
    let state: String
    //let postcode: Int?
}

struct NameWrapper: Codable {
    let title: String
    let first: String
    let last: String
}
