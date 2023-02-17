//
//  PBPillTests.swift
//  
//
//  Created by Alexandre Hauber on 04/10/21.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Playbook

final class PBPillTests: XCTestCase {
  func test_pill_default_equals_neutral() throws {
    let pill = PBPill("default")
    let textView = try pill.inspect().text()
    let textContent = try textView.string()
    let textBackgroundColor = try? textView.background().color()

    XCTAssertNotNil(textView)
    XCTAssertEqual(textContent, "default")
    XCTAssertNotNil(textBackgroundColor)
    XCTAssertEqual(try textBackgroundColor?.value(), PBColor.status(.neutral).color.opacity(0.12))
  }

  func test_pill_success_variant() throws {
    let pill = PBPill("success", variant: .success)
    let textView = try pill.inspect().text()
    let textContent = try textView.string()
    let textBackgroundColor = try? textView.background().color()

    XCTAssertNotNil(textView)
    XCTAssertEqual(textContent, "success")
    XCTAssertNotNil(textBackgroundColor)
    XCTAssertEqual(try textBackgroundColor?.value(), PBColor.status(.success).color.opacity(0.12))
  }
}
