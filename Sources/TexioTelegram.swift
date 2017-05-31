//
//  TexioTelegram.swift
//  TexioSwift
//
//  Created by Shayan on 5/30/17.
//
//

import Foundation


extension TexioClients {
    
    static var telegramCredentials = ["token" : "Telegram Bot Token Here"]
    
    static func telegramCleint(_ message : TexioText) {
        
        let route = "https://api.telegram.org/bot\(telegramCredentials["token"]!)/sendMessage"
        
        for chat_id in message.receivers {
            
            let params = ["chat_id" : chat_id,
                          "text" : message.text]
            
            TexioHTTP.makeRequest(route, params, .GET)
        }
        
    }
    
}





