import Foundation

typealias cellNumber = String

class Textio {
    
    /// initialize for multiple receivers
    /// - parameter receiver : receivers cell number
    /// - parameter text : message text
    func new(receiver : [cellNumber], text : String) -> TextioText {
        return TextioText(receiver: receiver, text: text)
    }
    
    /// initialize for one receiver only
    /// - parameter receiver : receiver's cell number
    /// - parameter text : message text
    func new(receiver : cellNumber, text : String) -> TextioText {
        return TextioText(receiver: receiver, text: text)
    }
    
    func builder(text : (TextioText) -> Void) {
        let builder = TextioText(receiver: [], text: "")
        text(builder)
    }
    
    private func send(_ message : TextioText) {
        
    }
    
}


class TextioText {
    
    private var receivers : [cellNumber]
    var text : String
    
    func addCells(_ cell : [cellNumber]) {
        receivers.append(contentsOf: cell)
    }
    
    func addCell(_ cell : cellNumber) {
        self.addCells([cell])
    }
    
    func removeAll() {
        self.receivers.removeAll()
    }
    
    init(receiver : [cellNumber], text : String) {
        self.receivers = receiver; self.text = text
    }
    
    /// initialize for one receiver only
    /// - parameter receiver : receiver's cell number
    /// - parameter text : message text
    convenience init(receiver : cellNumber, text : String) {
        self.init(receiver: [receiver], text: text)
    }
    
    func send() {}
    
}
