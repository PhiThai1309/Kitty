//
//  Month.swift
//  Kitty
//
//  Created by phi.thai on 4/25/23.
//

import Foundation

enum Month: Int{
    case Jan = 1
    case Feb = 2
    case Mar = 3
    case April = 4
    case May = 5
    case Jun = 6
    case July = 7
    case Aug = 8
    case Sep = 9
    case Oct = 10
    case Nov = 11
    case Dec = 12
    
    var description: String {
        switch self {
        case .Jan:
            return "January"
        case .Feb:
            return "Februrary"
        case .Mar:
            return "March"
        case .April:
            return "April"
        case .May:
            return "May"
        case .Jun:
            return "June"
        case .July:
            return "July"
        case .Aug:
            return "August"
        case .Sep:
            return "September"
        case .Oct:
            return "October"
        case .Nov:
            return "November"
        case .Dec:
            return "December"
        }
    }
}
