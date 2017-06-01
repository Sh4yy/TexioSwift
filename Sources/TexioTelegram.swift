//
//  TexioTelegram.swift
//  TexioSwift
//
//  Created by Shayan on 5/30/17.
//
//

import Foundation


extension TexioClients {
    
    static var TelegramToken : (String) = ""
    
    static func telegramCleint(_ message : TexioText) {
        
        let route = "https://api.telegram.org/bot\(TelegramToken)/sendMessage"
        
        var parameters = ["text" : message.text]
        
        for chat_id in message.receivers {
            parameters["chat_id"] = chat_id
            TexioHTTP.makeRequest(route, parameters, .GET)
        }
        
    }
    
}





