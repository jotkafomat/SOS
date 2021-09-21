//
//  ContentView + ViewModel.swift
//  SOS
//
//  Created by Krzysztof Jankowski on 19/09/2021.
//

import AVFoundation
import Combine
import Foundation

extension ContentView {
    
    class ViewModel: ObservableObject {
        
        @Published var titleText: String = "Press to send SOS"
        @Published var sliderValue: Float = 0.5
        
        private let device: AVCaptureDeviceProtocol?
        private var timerCancellable = Set<AnyCancellable>()
        static let sos: [AVCaptureDevice.TorchMode] = [
            .on, .off, .on, .off, .on,
            .off, .off, .off,
            .on, .on, .on, .off, .on, .on, .on, .off, .on, .on, .on,
            .off, .off, .off,
            .on, .off, .on, .off, .on,
            .off
        ]
        private let signalLength: TimeInterval
        
        public init(
            device: AVCaptureDeviceProtocol? = AVCaptureDevice.default(for: .video),
            signalLength: TimeInterval = 0.3) {
            self.device = device
            self.signalLength = signalLength
        }
                
        func sendMessage(_ message: [AVCaptureDevice.TorchMode] = sos) {
            titleText = "Sending SOS"
            let timer = Timer
                .publish(every: signalLength,tolerance: 0.05 ,on: RunLoop.main, in: .common)
                .autoconnect()
             Publishers.Zip(message.publisher, timer)
                .map{$0.0}
                .sink(
                    receiveCompletion: { [weak self] _ in
                        self?.titleText = "Press to send SOS"
                    },
                    receiveValue: { [weak self] torchMode in
                        guard let device = self?.device else { return }
                        guard device.hasTorch else { return }
                        do {
                            try device.lockForConfiguration()
                            if torchMode == .on {
                                try device.setTorchModeOn(level: min(self?.sliderValue ?? 0, AVCaptureDevice.maxAvailableTorchLevel))
                            } else {
                                device.torchMode = .off
                            }
                            device.unlockForConfiguration()
                        } catch {
                            print("Torch could not be used because: \(error.localizedDescription)")
                        }
                    })
                .store(in: &timerCancellable)
        }
    }
}
