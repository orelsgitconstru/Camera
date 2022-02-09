//
//  CameraNotInitializedError.swift
//  
//
//  Created by Orel Zilberman on 09/02/2022.
//

import Foundation

struct CameraNotInitializedError: Error{
    let message = "Camera Package not initlialized. Please run Camera.Initialize() before using the package."
}
