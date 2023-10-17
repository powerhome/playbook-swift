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
      let vc = AvatarCatalog().defaultAvatars

      assertSnapshot(matching: vc, as: .image)
    }

    func testPBAvatarMonogram() {
      let vc = AvatarCatalog().monograms

      assertSnapshot(matching: vc, as: .image)
    }
  }
#endif
