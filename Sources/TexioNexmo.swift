//
//  TexioNeximop.swift
//  TexioSwift
//
//  Created by Shayan on 5/30/17.
//
//

import Foundation

extension TexioClients {
    
    fileprivate enum NexmoAPI : String {
        case KEY = "api_key"
        case SECRET = "api_secret"
        case FROM = "api from"
        case URL = "https://rest.nexmo.com/sms/json"
    }
    
    static func nexmoClient(_ message : TexioText) {
        
        var parameters = ["api_key"    : NexmoAPI.KEY.rawValue,
                          "api_secret" : NexmoAPI.SECRET.rawValue,
                          "from"       : NexmoAPI.FROM.rawValue,
                          "text"       : message.text
        ]
        
        for phone_number in message.receivers {
            parameters["to"] = phone_number
            TexioHTTP.makeRequest(NexmoAPI.URL.rawValue, parameters, .POST)
        }
        
    }
    
    
    
}
