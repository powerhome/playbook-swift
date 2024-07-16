//
//  AvatarTests.swift
//
//
//  Created by Gavin Huang on 3/7/23.
//

import SnapshotTesting
import XCTest
import SwiftUI
@testable import Playbook

#if os(iOS)
class AvatarTests: XCTestCase {
    func testAvatarDefault() {
        let vc = AvatarCatalog().defaultAvatars
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testAvatarMonogram() {
        let vc = AvatarCatalog().monograms
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testAvatar() {
        let avatar = PBAvatar(
            image: Image("andrew", bundle: .module),
            size: .xLarge,
            status: .online
        )
        assertSnapshots(matching: avatar, as: [.image])
    }
}
#endif
