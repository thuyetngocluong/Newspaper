//
//  StringExtension.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 05/07/2021.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation

extension String {
    
    var toLinkImage: String {
        do {
            let regex = try NSRegularExpression(pattern: "(?:src\\s*=\\s*\")([^\"]*)(?:\")")
            let results = regex.matches(in: self,
                                        range: NSMakeRange(0, self.count))
            
            if results.count > 0, let range = Range(results[0].range(at: 1), in: self) {
                return String(self[range])
            }
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
        }

        return ""
    }
    
    var toPreview: String {
        do {
            let regex = try NSRegularExpression(pattern: "(?:</br>)([^]]*)(?:]*)")
            let results = regex.matches(in: self,
                                        range: NSMakeRange(0, self.count))
            if results.count > 0, let range = Range(results[0].range(at: 1), in: self) {
                return String(self[range]).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
        }

        return ""
    }
    
    var toDateAgo: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        if let date = formatter.date(from: self) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "H"
            return hourFormatter.string(from: Date(timeIntervalSince1970: Date().timeIntervalSince1970 -  date.timeIntervalSince1970))
        }
        
        return ""
    }
}
