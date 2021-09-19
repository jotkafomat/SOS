//
//  AVCaptureDeviceProtocol.swift
//  SOS
//
//  Created by Krzysztof Jankowski on 19/09/2021.
//

import Foundation
import AVFoundation

protocol AVCaptureDeviceProtocol: AnyObject {
    var hasTorch: Bool { get }
    var torchMode: AVCaptureDevice.TorchMode { get set }
    func lockForConfiguration() throws
    func unlockForConfiguration()
}

extension AVCaptureDevice: AVCaptureDeviceProtocol {}
