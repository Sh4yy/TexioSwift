import XCTest
@testable import TexioSwift

class TexioSwiftTests: XCTestCase {
    func testExample() {
    
        let texio = Texio()
        
        let message = texio.new(receiver: "234", text: "hey")
        
        message.send(.neximo)
        
        texio.builder { text in
            text.addCell("326520335")
            text.text = "hey this is shayan call me later"
        }
        
    }
    
    func testSendToTelegram() {
        
        let texio = Texio()
        
        texio.builder { builder in
            builder.addCell("124858558")
            builder.text = "hey shayan"
            builder.send(.telegram)
        }
        
        waitForExpectations(timeout: 19) { error in
            print("error")
        }
        
    }

    
    func testMakeNotification() {
        
        let notification = TexioNotification.FileteredNotification()
        notification.app_version(relation: .greater, value: "1.0.0")
        notification.operation(.or)
        notification.first_session(relation: .greater, hoursAgo: 5)
        
        notification.delayed_option(.sendAfter)
        notification.send_after(Date().description)
        
        notification.addContent(.Persian, text: "hey this is a persian notification")
        notification.addContent(.English, text: "hey this is an english notification")
        notification.addHeading(.Persian, text: "persian heading")
        notification.addHeading(.English, text: "english heading")
        notification.addSubtitle(.Persian, text: "persian subtitle")
        notification.addSubtitle(.English, text: "english subtitle")
        
        notification.mutable_content = true
        notification.tag(relation: .equal, key: "premium", value: "true")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: notification.parameters, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString!)
        } catch(let error) {
            print("\(error)")
        }
        
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
