//
//  PopoverViewModel.swift
//  OneTracker
//
//  Created by Max Kuznetsov on 17.03.2023.
//

import SwiftUI

final class PopoverViewModel: ObservableObject {
    @Published var batteryTimeLeft: String?
    @Published var batteryUsage: String?
    @Published var batteryProgress: Double = 0.0
    
    @Published var memTotal: String?
    @Published var memWired: String?
    @Published var memCompressed: String?
    @Published var memProgress: Double = 0.0
    
    @Published var diskTotal: String?
    @Published var diskFree: String?
    @Published var diskUsed: String?
    @Published var diskProgress: Double = 0.0
    
    @Published var cpuSystem: String?
    @Published var cpuUser: String?
    @Published var cpuIdle: String?
    @Published var cpuProgress: Double = 0.0
    
    init() {
        updateSystemInfo()
    }
    
    func updateSystemInfo() {
        DispatchQueue.global().sync {
            _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { [weak self] timer in
                DispatchQueue.main.async {
                    self?.getBatteryInfo()
                    self?.getMemInfo()
                    self?.getCpuInfo()
                    self?.getDiskInfo()
                }
            })
        }
    }
    
    private func getBatteryInfo() {
        batteryTimeLeft = BatteryInfo.shared.getInternalBattery()?.timeLeft
        batteryProgress = (BatteryInfo.shared.getInternalBattery()?.temperature)! / 100
    }
    
    private func getMemInfo() {
        MemoryInfo.shared.update()
        memTotal = "\(MemoryInfo.shared.app)"
        memWired = "\(MemoryInfo.shared.wired)"
        memCompressed = "\(MemoryInfo.shared.compressed)"
        memProgress = MemoryInfo.shared.percentage / 100
    }
    
    private func getCpuInfo() {
        CpuInfo.shared.update()
        cpuSystem = "\(CpuInfo.shared.system)"
        cpuUser = "\(CpuInfo.shared.user)"
        cpuIdle = "\(CpuInfo.shared.idle)"
        cpuProgress = CpuInfo.shared.percentage / 100
    }
    
    private func getDiskInfo() {
        DiskInfo.shared.update()
        diskTotal = DiskInfo.shared.total
        diskUsed = DiskInfo.shared.used
        diskFree = DiskInfo.shared.free
        diskProgress = DiskInfo.shared.percentage / 100
    }
}
