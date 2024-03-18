import XCTest
@testable import AronPreview

final class AronPreviewTests: XCTestCase {
  func testExample() throws {
    XCTAssertEqual(echo(), "Hello, World!!")
  }

  func echo() -> String {
    "Hello, World!!"
  }
}
