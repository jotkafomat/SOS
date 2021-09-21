//
//  ContentViewViewModelTests.swift
//  ContentViewViewModelTests
//
//  Created by Krzysztof Jankowski on 18/09/2021.
//

import AVFoundation
import XCTest
@testable import SOS

class ContentViewViewModelTests: XCTestCase {
        
    func testWhenSendMessageCalledWithSequenceCaptureDeviceTorchModeGetSetsToTheSameValuesInOrder() {
        let message = [AVCaptureDevice.TorchMode.on, .off, .on, .on]
        let avCaptureDeviceSpy = AVCaptureDeviceSpy(expectedMessage: message)
        
        avCaptureDeviceSpy.messageReceived = expectation(description: "Message was received")
        
        let sut = ContentView.ViewModel(device: avCaptureDeviceSpy, signalLength: 0.01)
        
        sut.sendMessage(message)
        
        waitForExpectations(timeout: 1)
    }
}
