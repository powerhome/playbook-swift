//
//  PBMultipleUsersTests.swift
//  
//
//  Created by Isis Silva on 31/01/23.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Playbook


final class PBMultipleUsersTests: XCTestCase {
    static let andrew = PBUser(name: "Andrew Kloecker")
    static let picAndrew = PBUser(name: "Andrew Kloecker", image: Image("andrew", bundle: .module))
    let multipleUsers = [andrew, picAndrew, andrew, andrew, andrew]

    func testAdditionalUser() throws {
        let subject = PBMultipleUsers(users: multipleUsers)
        let additionalUser = try subject.inspect().find(viewWithTag: "additionalUser").text().string()
        XCTAssertEqual(additionalUser, "+2")
    }
}
