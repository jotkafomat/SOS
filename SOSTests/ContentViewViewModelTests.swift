//
//  ContentViewViewModelTests.swift
//  ContentViewViewModelTests
//
//  Created by Krzysztof Jankowski on 18/09/2021.
//

import XCTest
@testable import SOS

class ContentViewViewModelTests: XCTestCase {
    
    func testTurnOnFlash() {
        let sut = ContentView.ViewModel(device: AVCaptureDeviceMock())
        XCTAssertEqual(sut.device?.torchMode, .off)
        
        sut.turnOnFlash()
        
        XCTAssertEqual(sut.device?.torchMode, .on)
    }
    
    func testTurnsFlashOff() {
        let spyTorchOperator = AVCaptureDeviceSpy()
        spyTorchOperator.torchModeOff = expectation(description: "torch off")
        
        let sut = ContentView.ViewModel(device: spyTorchOperator)
        
        sut.turnFlashOff(after: 0)
        
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(sut.device?.torchMode, .off)
    }
}
