import XCTest
@testable import TexioSwift

class TexioSwiftTests: XCTestCase {
    func testExample() {
    
        let textio = Textio()
        
        let message = textio.new(receiver: "234", text: "hey")
        
        message.send()
        
        textio.builder { text in
            text.addCell("326520335")
            text.text = "hey this is shayan call me later"
        }
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
