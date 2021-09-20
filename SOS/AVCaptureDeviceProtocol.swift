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
    static var maxAvailableTorchLevel: Float { get }
    func setTorchModeOn(level torchLevel: Float) throws
    func lockForConfiguration() throws
    func unlockForConfiguration()
}

extension AVCaptureDevice: AVCaptureDeviceProtocol {}
