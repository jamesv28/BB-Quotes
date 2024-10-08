//
//  Character.swift
//  BB-Quotes
//
//  Created by James Volmert on 10/7/24.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death?
    
}
