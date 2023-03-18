//
//  Double+Extension.swift
//  OneTracker
//
//  Created by Max Kuznetsov on 17.03.2023.
//

import Foundation

extension Double {
    mutating func roundTo(_ precision: Int) {
        round(self * 10*precision) / 10*precision
    }
}
