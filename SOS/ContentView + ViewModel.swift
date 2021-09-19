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
    class ViewModel {
        
        let device: AVCaptureDeviceProtocol?
        var timerCancellable: AnyCancellable?
        
        public init(device: AVCaptureDeviceProtocol? = AVCaptureDevice.default(for: .video)) {
            self.device = device
        }
        
        func turnOnFlash() {
            guard let device = device else { return }
            guard device.hasTorch else { return }
            
            do {
                try device.lockForConfiguration()
                device.torchMode = .on
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used because: \(error.localizedDescription)")
            }
        }
        
        func turnFlashOff(after delay: Double = 2) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                guard let device = self?.device else { return }
                guard device.hasTorch else { return }
                
                do {
                    try device.lockForConfiguration()
                    device.torchMode = .off
                    device.unlockForConfiguration()
                } catch {
                    print("Torch could not be used because: \(error.localizedDescription)")
                }
            }
        }
        
        func toggleFlash() {            
            timerCancellable = Timer
                .publish(every: 1, tolerance: 0.1 ,on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    if self.device?.torchMode == .off {
                        self.turnOnFlash()
                    } else {
                        self.turnFlashOff(after: 0)
                    }
                }
        }
    }
}
