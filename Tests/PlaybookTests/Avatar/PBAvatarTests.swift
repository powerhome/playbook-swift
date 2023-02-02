import XCTest
import SwiftUI
import ViewInspector
@testable import Playbook

final class PBAvatarTests: XCTestCase {

    func testMonogram() throws {
        let subject = PBAvatar(name: "Test Fest")
        let initials = try subject.inspect().find(viewWithTag: "monogram").text().string()
        XCTAssertEqual(initials, "TF")
    }
}

extension PBAvatar: Inspectable {}
