//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ButtonTests.swift
//

import SnapshotTesting
import XCTest
@testable import Playbook

#if os(iOS)
class ButoonTests: XCTestCase {
    func testButtonDefault() {
        let component = ButtonsCatalog().simpleButtons.fixedSize()
        assertSnapshot(matching: component, as: .image)
    }
    
    func testButtonReaction() {
        let component = ButtonsCatalog().reactionButtonView.fixedSize()
        assertSnapshot(matching: component, as: .image)
    }
    
    func testButtonWidth() {
        let component = ButtonsCatalog().fullWidthButtonView.fixedSize()
        assertSnapshot(matching: component, as: .image)
    }
    
    func testButtonIcon() {
        let component = ButtonsCatalog().buttonIconView.fixedSize()
        assertSnapshot(matching: component, as: .image)
    }
    
    func testButtonCircle() {
        let component = ButtonsCatalog().circleButtonView.fixedSize()
        assertSnapshot(matching: component, as: .image)
    }
    
    func testButtonSize() {
        let component = ButtonsCatalog().buttonSizeView.fixedSize()
        assertSnapshot(matching: component, as: .image)
    }
    
    func testButtonLoading() {
        let component = ButtonsCatalog().buttonLoadingView.fixedSize()
        assertSnapshot(matching: component, as: .image)
    }
}
#endif
