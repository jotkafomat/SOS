//
//  AVCaptureDeviceMock.swift
//  SOSTests
//
//  Created by Krzysztof Jankowski on 19/09/2021.
//

import AVFoundation
@testable import SOS


class AVCaptureDeviceMock: AVCaptureDeviceProtocol {
    var hasTorch: Bool { true }
    
    var torchMode: AVCaptureDevice.TorchMode = .off
    
    func lockForConfiguration() throws {}
    
    func unlockForConfiguration() {}
    
}
