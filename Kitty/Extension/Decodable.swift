//
//  Decodable.swift
//  Kitty
//
//  Created by phi.thai on 5/15/23.
//

import Foundation

extension Decodable {
    /// Initialize from JSON Dictionary. Return nil on failure
    init?(dictionary value: [String:Any]) {
        guard JSONSerialization.isValidJSONObject(value) else {
            return nil
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let newValue = try JSONDecoder().decode(Self.self, from: jsonData)
            self = newValue
        }
        catch {
//            log.error("failed to serialize data: \(error)")
            return nil
        }
    }
}
