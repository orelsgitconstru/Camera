//
//  File.swift
//  
//
//  Created by Orel Zilberman on 09/02/2022.
//

import Foundation

public struct State: CameraResponse{
    let sessionId: String?
    let batteryLevel: Double?
    let storageChanged: Bool?
    let _captureStatus: String?
    let _recordedTime: Int64?
    let _recordableTime: Int64?
    let _compositeShootingElapsedTime: Int?
    let _latestFileUri: String?
    let _batteryState: String?
    let _apiVersion: Int64?
    let _cameraError: [String]?
}
