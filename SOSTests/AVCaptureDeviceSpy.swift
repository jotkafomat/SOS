//
//  AVCaptureDeviceSpy.swift
//  SOSTests
//
//  Created by Krzysztof Jankowski on 19/09/2021.
//

import AVFoundation
import XCTest
@testable import SOS


class AVCaptureDeviceSpy: AVCaptureDeviceProtocol {
    
    var torchModeOff: XCTestExpectation?
    
    var hasTorch: Bool {
        true
    }
    
    var torchMode: AVCaptureDevice.TorchMode = .on {
        didSet {
            if torchMode == .off {
                torchModeOff?.fulfill()
            }
        }
    }
    
    func lockForConfiguration() throws { }
    
    func unlockForConfiguration() { }
    
    
}
