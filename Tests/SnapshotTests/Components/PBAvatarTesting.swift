//
//  PBAvatarTesting.swift
//
//
//  Created by Gavin Huang on 3/7/23.
//

import SnapshotTesting
import XCTest
@testable import Playbook

#if os(iOS)
  class PBAvatarTesting: XCTestCase {
    func testPBAvatarDefault() {
      let vc = PBAvatar_Previews.defaultAvatars

      assertSnapshot(matching: vc, as: .image)
    }

    func testPBAvatarMonogram() {
      let vc = PBAvatar_Previews.monograms

      assertSnapshot(matching: vc, as: .image)
    }
  }
#endif
