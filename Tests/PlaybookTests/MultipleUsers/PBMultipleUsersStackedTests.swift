//
//  PBMultipleUsersStackedTests.swift
//
//
//  Created by Isis Silva on 31/01/23.
//

@testable import Playbook
import SwiftUI
import ViewInspector
import XCTest

final class PBMultipleUsersStackedTests: XCTestCase {
  static let andrew = PBUser(name: "Andrew Kloecker")
  static let picAndrew = PBUser(name: "Andrew Kloecker", image: Image("andrew", bundle: .module))
  let multipleUsers = [andrew, picAndrew, andrew, andrew, andrew]
  let twoUsersWithImage = [picAndrew, picAndrew]
  let twoUsersWithoutImage = [andrew, andrew]

  func testMultipleUser() throws {
    let subject = PBMultipleUsersStacked(users: multipleUsers)
    let additionalUser = try subject.inspect().find(viewWithTag: "additionalUser").text().string()
    XCTAssertEqual(additionalUser, "+4")
  }

  func testMultipleUsersImage() throws {
    let subject = PBMultipleUsersStacked(users: twoUsersWithImage)
    let userImage = try subject.inspect().find(viewWithTag: "userImage").image().actualImage()
    XCTAssertNotNil(userImage)
  }

  func testMultipleUsersWithoutImage() throws {
    let subject = PBMultipleUsersStacked(users: twoUsersWithoutImage)
    let users = try subject.inspect().find(viewWithTag: "monogram").text().string()
    XCTAssertEqual(users, "AK")
  }
}
