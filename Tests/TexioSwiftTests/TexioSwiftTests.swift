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

    static var allTests = [
        ("testExample", testExample),
    ]
}
