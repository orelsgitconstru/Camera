//
//  File.swift
//  
//
//  Created by Orel Zilberman on 09/02/2022.
//

import Foundation

public struct Capture: CameraResponse{
    var name: String?
    var state: String?
    var id: String?
    var results: Results?
    var error: CaptureError
    
    struct CaptureError{
        var message: String
        var code: String
    }
    
    struct Results{
        var options: Options?
        
        init(data: [String: Any]?){
            if(data == nil) {return}
            self.options = Options(exposureProgram: data?["exposureProgram"] as? Int ?? nil, exposureProgramSupport: data?["exposureProgramSupport"] as? [Int] ?? nil)
        }
        
        struct Options {
            var exposureProgram: Int?
            var exposureProgramSupport: [Int]?
        }
    }
}
