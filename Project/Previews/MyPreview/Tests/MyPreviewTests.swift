import XCTest
@testable import MyPreview

final class MyPreviewTests: XCTestCase {
  func testExample() throws {
    XCTAssertEqual(echo(), "Hello, World!!")
  }

  func echo() -> String {
    "Hello, World!!"
  }
}
