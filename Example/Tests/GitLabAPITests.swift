import XCTest
@testable import GLCodeReview

struct TestDate: Codable {
    let date: Date
}

class GitLabAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testIso8601DateDecoding() {
        let iso8601DateData = "{\"date\": \"2016-11-17T17:51:15.1720Z\"}".data(using: .utf8)!
        let testDate = try! GitLabAPI.decoder.decode(TestDate.self, from: iso8601DateData)
        XCTAssertEqual(testDate.date.timeIntervalSince1970, 1479405075.172)
    }
    
    func testIso8601NoFractionalSecondsDateDecoding() {
        let iso8601NoFsDateData = "{\"date\": \"2016-11-17T17:51:15Z\"}".data(using: .utf8)!
        let testDate = try! GitLabAPI.decoder.decode(TestDate.self, from: iso8601NoFsDateData)
        XCTAssertEqual(testDate.date.timeIntervalSince1970, 1479405075)
    }
    
    func testDateDecodingFailure() {
        let invalidDateData = "{\"date\": \"2016-11-17T17:515.1720Z\"}".data(using: .utf8)!
        XCTAssertThrowsError(try GitLabAPI.decoder.decode(TestDate.self, from: invalidDateData), "") { (error) in
            let decodingError = error as! DecodingError
            if case .dataCorrupted(let context) = decodingError {
                enum DateTestCodingKeys: String, CodingKey {
                    case date
                }
                XCTAssertEqual(context.codingPath.map { $0.stringValue }, ["date"])
                XCTAssertEqual(context.debugDescription, "Invalid date: 2016-11-17T17:515.1720Z")
                XCTAssertNil(context.underlyingError)
            } else {
                XCTFail("Expected a DecodingError.dataCorrupted error")
            }
        }
    }
}
