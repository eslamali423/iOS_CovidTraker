//
//  Global.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import Foundation




extension DateFormatter {
    static let dayFormatter : DateFormatter = {
      let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
    
    static let prettyFormatter : DateFormatter = {
      let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
    
}

