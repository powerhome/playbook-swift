//
//  PBDialogTests.swift
//
//
//  Created by Alexandre Hauber on 20/08/21.
//

@testable import Playbook
import SwiftUI
import ViewInspector
import XCTest

final class PBDialogTests: XCTestCase {
  func test_dialog_simple() throws {
    let dialog = PBDialog(
      title: "Simple title",
      text: "Simple text",
      cancelButton: "Cancel",
      confirmButton: "OK"
    ) {}
    let modifier = dialog.modifier(self)
    let content = modifier.content
    let pbCard = try dialog.inspect().find(viewWithTag: "card")
    let title = try pbCard.find(viewWithTag: "title").text().string()
    let text = try pbCard.find(viewWithTag: "text").text().string()
    let cancelButton = try pbCard.find(viewWithTag: "cancelButton").button()
    let cancelButtonStyle = try cancelButton.buttonStyle() as? PBButtonStyle
    let confirmButton = try pbCard.find(viewWithTag: "confirmButton").button()
    let confirmButtonStyle = try confirmButton.buttonStyle() as? PBButtonStyle
    let closeIcon = try dialog.inspect().find(viewWithTag: "closeIcon")

    XCTAssertNotNil(pbCard)
    XCTAssertEqual(content.size, .medium)
    XCTAssertEqual(title, "Simple title")
    XCTAssertEqual(text, "Simple text")
    XCTAssertEqual(cancelButtonStyle?.variant, .link)
    XCTAssertEqual(confirmButtonStyle?.variant, .primary)
    XCTAssertEqual(try cancelButton.labelView().text().string(), "Cancel")
    XCTAssertEqual(try confirmButton.labelView().text().string(), "OK")
    XCTAssertNotNil(closeIcon)
  }

  // TODO: - Fix dialog complex and create a test fot it

  func test_dialog_small() throws {
    let dialog = PBDialog(size: .small) {}
    let modifier = dialog.modifier(self)
    let content = modifier.content

    XCTAssertEqual(content.size, .small)
  }
}
