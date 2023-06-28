//
//  DateFormatter+Helper.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import Foundation
extension DateFormatter {
    static func localizedDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}


