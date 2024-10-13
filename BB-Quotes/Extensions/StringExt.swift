//
//  StringExt.swift
//  BB-Quotes
//
//  Created by James Volmert on 10/13/24.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCasesAndSpaces() -> String {
        self.removeSpaces().lowercased()
    }
}
