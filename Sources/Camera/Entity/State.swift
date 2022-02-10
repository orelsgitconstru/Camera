//
//  File.swift
//  
//
//  Created by Orel Zilberman on 09/02/2022.
//

import Foundation

struct State: CameraResponse{
    let sessionId: String?
    let batteryLevel: Int?
    let storageChanged: Bool?
    let _captureStatus: String?
    let _recordedTime: Int?
    let _recordableTime: Int?
    let _compositeShootingElapsedTime: Int?
    let _latestFileUri: String?
    let _batteryState: String?
    let _apiVersion: Int?
    let _cameraError: [String]?
}
