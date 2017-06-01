//
//  TexioNeximop.swift
//  TexioSwift
//
//  Created by Shayan on 5/30/17.
//
//

import Foundation

extension TexioClients {
    
    static var NexmoAPI : (Key : String,
                           Secret : String,
                           From : String,
                           URL : String)
        = ("","","","")
    
    static func nexmoClient(_ message : TexioText) {
        
        var parameters = ["api_key"    : NexmoAPI.Key,
                          "api_secret" : NexmoAPI.Secret,
                          "from"       : NexmoAPI.From,
                          "text"       : message.text
        ]
        
        for phone_number in message.receivers {
            parameters["to"] = phone_number
            TexioHTTP.makeRequest(NexmoAPI.URL, parameters, .POST)
        }
        
    }
    
    
    
}
