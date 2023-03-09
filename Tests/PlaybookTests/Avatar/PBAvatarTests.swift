@testable import Playbook
import SwiftUI
import ViewInspector
import XCTest

final class PBAvatarTests: XCTestCase {
  func testMonogram() throws {
    let subject = PBAvatar(name: "Test Fest")
    let initials = try subject.inspect().find(viewWithTag: "monogram").text().string()
    XCTAssertEqual(initials, "TF")
  }
}
