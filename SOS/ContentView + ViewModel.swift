//
//  ContentView + ViewModel.swift
//  SOS
//
//  Created by Krzysztof Jankowski on 19/09/2021.
//

import Foundation
import AVFoundation

extension ContentView {
    class ViewModel {
        
        var device: AVCaptureDeviceProtocol?
        
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
    }
}
