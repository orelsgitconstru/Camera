//
//  Dictionary+Extension.swift
//  
//
//  Created by Orel Zilberman on 09/02/2022.
//

import Foundation

extension Dictionary where Key == String{
    func toState() -> State{
        return State(sessionId: self["sessionId"] as? String, batteryLevel: self["batteryLevel"] as? Double, storageChanged: self["storageChanged"] as? Bool, _captureStatus: self["_captureStatus"] as? String, _recordedTime: self["_recordedTime"] as? Int64, _recordableTime: self["_recordableTime"] as? Int64, _compositeShootingElapsedTime: self["_compositeShootingElapsedTime"] as? Int64, _latestFileUri: self["_latestFileUrl"] as? String, _batteryState: self["_batteryState"] as? String, _apiVersion: self["_apiVersion"] as? Int64, _cameraError: self["_cameraError"] as? [String])
    }
    
    func toCapture() -> Capture{
        return Capture(name: self["name"] as? String, state: self["state"] as? String, id: self["id"] as? String, results: Capture.Results(data: self["results"] as? [String : Any]))
    }
}
