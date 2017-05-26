import Foundation

typealias receiverId = String

class Texio {
    
    /// initialize for multiple receivers
    /// - parameter receiver : receivers cell number
    /// - parameter text : message text
    func new(receiver : [receiverId], text : String) -> TexioText {
        return TexioText(receiver: receiver, text: text)
    }
    
    /// initialize for one receiver only
    /// - parameter receiver : receiver's cell number
    /// - parameter text : message text
    func new(receiver : receiverId, text : String) -> TexioText {
        return TexioText(receiver: receiver, text: text)
    }
    
    func builder(text : (TexioText) -> Void) {
        let builder = TexioText(receiver: [], text: "")
        text(builder)
    }
    
    private func send(_ message : TexioText) {
        
    }
    
}


class TexioText {
    
    var receivers : [receiverId]
    var text : String
    
    func addCells(_ cell : [receiverId]) {
        receivers.append(contentsOf: cell)
    }
    
    func addCell(_ cell : receiverId) {
        self.addCells([cell])
    }
    
    func removeAll() {
        self.receivers.removeAll()
    }
    
    init(receiver : [receiverId], text : String) {
        self.receivers = receiver; self.text = text
    }
    
    /// initialize for one receiver only
    /// - parameter receiver : receiver's cell number
    /// - parameter text : message text
    convenience init(receiver : receiverId, text : String) {
        self.init(receiver: [receiver], text: text)
    }
    
    enum clients {
        case telegram
        case neximo
    }
    
    func send(_ to : clients) {
        switch to {
        case .neximo: TexioClients.telegramCleint(self)
        case .telegram: TexioClients.telegramCleint(self)
        }
    }
    
}


class TexioClients {
}

extension TexioClients {
    
    static var telegramCredentials = ["token" : "243820160:AAFhhft325hcQQ4HtdjuYPWG8lLmx_ZWQEM"]
    
    static func telegramCleint(_ message : TexioText) {
        
        let route = "https://api.telegram.org/bot\(telegramCredentials["token"]!)/sendMessage"
        
        for chat_id in message.receivers {
            
            let params = ["chat_id" : chat_id,
                          "text" : message.text]
            
            TexioHTTP.makeRequest(route, params, .GET)
        }
        
    }
    
}















