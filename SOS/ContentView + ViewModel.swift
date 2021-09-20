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
        
        let device: AVCaptureDeviceProtocol?
        private var timerCancellable: AnyCancellable?
        static let sos: [AVCaptureDevice.TorchMode] = [
            .on, .off, .on, .off, .on,
            .off, .off, .off,
            .on, .on, .on, .off, .on, .on, .on, .off, .on, .on, .on,
            .off, .off, .off,
            .on, .off, .on, .off, .on,
            .off
        ]
        private let signalLength: TimeInterval
        
        public init(device: AVCaptureDeviceProtocol? = AVCaptureDevice.default(for: .video), signalLength: TimeInterval = 0.3) {
            self.device = device
            self.signalLength = signalLength
        }
                
        func sendMessage(_ message: [AVCaptureDevice.TorchMode] = sos) {

            let timer = Timer
                .publish(every: signalLength,tolerance: 0.05 ,on: RunLoop.main, in: .common)
                .autoconnect()
            timerCancellable = Publishers.Zip(message.publisher, timer)
                .sink(receiveCompletion: { [weak self]_ in
                    self?.titleText = "Press to send SOS"
                },
                      receiveValue: { [weak self] flashMode, _ in
                    guard let device = self?.device else { return }
                    guard device.hasTorch else { return }
                    self?.titleText = "Sending SOS"
                    do {
                        try device.lockForConfiguration()
                        if flashMode == .on {
                            try device.setTorchModeOn(level: min(self?.sliderValue ?? 0, AVCaptureDevice.maxAvailableTorchLevel))
                        } else {
                            device.torchMode = .off
                        }
                        device.unlockForConfiguration()
                    } catch {
                        print("Torch could not be used because: \(error.localizedDescription)")
                    }
                })
        }
    }
}
