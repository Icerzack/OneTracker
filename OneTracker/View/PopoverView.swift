//
//  PopoverView.swift
//  OneTracker
//  Created by Max Kuznetsov on 16.03.2023.
//

import SwiftUI

struct PopoverView: View {
    @State var titleMem = "MEM"
    @State var titleCpu = "CPU"
    @State var titleDisk = "DISK"
    @State var titleAcc = "ACC"

    @State var imageMem = "memorychip"
    @State var imageCpu = "cpu"
    @State var imageDisk = "opticaldiscdrive"
    @State var imageAcc = "battery.50"

    @StateObject var viewModel = PopoverViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                Spacer()
                VStack {
                    CircleProgressBar(title: $titleMem, color: .green, progress: $viewModel.memProgress, imageString: $imageMem ).frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Usage: "+(viewModel.memTotal ?? "N/D"))
                        Text("Compressed: "+(viewModel.memCompressed ?? "N/D"))
                        Text("Wired: "+(viewModel.memWired ?? "N/D"))
                    }
                }.padding(.top, 10)
                Spacer()
            }
            Divider()
            HStack {
                Spacer()
                VStack {
                    CircleProgressBar(title: $titleCpu, color: .red, progress: $viewModel.cpuProgress, imageString: $imageCpu).frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("System: "+(viewModel.cpuSystem ?? "N/D"))
                        Text("User: "+(viewModel.cpuUser ?? "N/D"))
                        Text("Idle: "+(viewModel.cpuIdle ?? "N/D"))
                    }
                }.padding(.top, 10)
                Spacer()
            }
            Divider()
            HStack {
                Spacer()
                VStack {
                    CircleProgressBar(title: $titleDisk, color: .yellow, progress: $viewModel.diskProgress, imageString: $imageDisk).frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Total: "+(viewModel.diskTotal ?? "N/D"))
                        Text("Used: "+(viewModel.diskUsed ?? "N/D"))
                        Text("Free: "+(viewModel.diskFree ?? "N/D"))
                    }
                }.padding(.top, 10)
                Spacer()
            }
            Divider()
            HStack {
                Spacer()
                VStack {
                    CircleProgressBar(title: $titleAcc, color: .blue, progress: $viewModel.batteryProgress, imageString: $imageAcc).frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Time left: "+(viewModel.batteryTimeLeft ?? "N/D"))
                    }
                }.padding(.top, 10)
                Spacer()
            }
            
        }.frame(width: 600, height: 125)
        
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView()
    }
}

struct CircleProgressBar: View {
    @Binding var title: String
    @State var color: Color
    @Binding var progress: Double
    @Binding var imageString: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 5)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(color, lineWidth: 5)
                .rotationEffect(Angle(degrees: -90))
            
            VStack(spacing: 0) {
                Image(systemName: imageString)
                Text("\(title)").font(.subheadline)
            }
        }
    }
}
