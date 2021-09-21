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
    
    let expectedMessage: [AVCaptureDevice.TorchMode]
    var messageReceived: XCTestExpectation?
    private(set) var actualMessage: [AVCaptureDevice.TorchMode] = [] {
        didSet {
            if expectedMessage == actualMessage {
                messageReceived?.fulfill()
            }
        }
    }
    
    static var maxAvailableTorchLevel: Float = 1
    
    var hasTorch: Bool {
        true
    }
    
    var torchMode: AVCaptureDevice.TorchMode = .on {
        didSet {
            actualMessage.append(torchMode)
        }
    }
    
    init(expectedMessage: [AVCaptureDevice.TorchMode]) {
        self.expectedMessage = expectedMessage
    }
    
    func setTorchModeOn(level torchLevel: Float) throws {
        torchMode = .on
    }
    
    func lockForConfiguration() throws { }
    
    func unlockForConfiguration() { }
}
