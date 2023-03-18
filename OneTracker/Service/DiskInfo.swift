//
//  DiskInfo.swift
//  OneTracker
//
//  Created by Max Kuznetsov on 17.03.2023.
//


import Foundation

final class DiskInfo {
    
    var percentage: Double = 0.0
    var total = "N/D"
    var free = "N/D"
    var used = "N/D"
    
    private init() {}
    
    static let shared = DiskInfo()
    
    private func convertByteData(byteCount: Int64) -> String {
        let fmt = ByteCountFormatter()
        fmt.countStyle = .decimal
        let array = fmt.string(fromByteCount: byteCount)
            .replacingOccurrences(of: ",", with: ".")
            .components(separatedBy: .whitespaces)
        return "\(Double(array[0]) ?? 0.0) \(array[1])"
    }
    
    func update() {
        let url = NSURL(fileURLWithPath: "/")
        let keys: [URLResourceKey] = [.volumeTotalCapacityKey, .volumeAvailableCapacityForImportantUsageKey]
        guard let dict = try? url.resourceValues(forKeys: keys) else { return }
        let total = (dict[URLResourceKey.volumeTotalCapacityKey] as! NSNumber).int64Value
        let free = (dict[URLResourceKey.volumeAvailableCapacityForImportantUsageKey] as! NSNumber).int64Value
        let used: Int64 = total - free
        
        self.percentage = round(min(99.9, (100.0 * Double(used) / Double(total))) * 100) / 100
        
        self.total = convertByteData(byteCount: total)
        self.free  = convertByteData(byteCount: free)
        self.used  = convertByteData(byteCount: used)
    }
}





