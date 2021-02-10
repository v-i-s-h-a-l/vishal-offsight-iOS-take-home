//
//  Utilities.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Foundation

struct Constant {
    
    // declared as private, to avoid public initialisation
    // as we don't want any instance of this struct to be created
    private init() { }
    
    static let baseURLString = "https://dummyapi.io/data/api/"
    static let dummyAPIAppID = "601c0db428eabc0fd5412f32"
    
    static let loadingViewTag = 123
}

enum DateHelper {

    private static var apiDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFractionalSeconds
        return formatter
    }()
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        return dateFormatter
    }()
    
    static func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    static func apiDate(from string: String?) -> Date? {
        guard let dateString = string else { return nil }
        return apiDateFormatter.date(from: dateString)
    }
}
