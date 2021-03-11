//
//  AndesTooltipTests.swift
//  AndesUI_Tests
//
//  Created by Juan Andres Vasquez Ferrer on 16-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import AndesUI

class AndesTooltipTests: QuickSpec {
    override func spec() {

        var rootView: UIView!
        var childView: UIView!
        var targetView: UIView!

        describe("AndesTooltip should draw") {
            beforeEach {
                rootView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                childView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                targetView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

                rootView.addSubview(childView)
                childView.addSubview(targetView)
            }

            context("execute clousure") {
                it("should execute dismissHandler clousure") {
                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content")

                    var dismissIsCalled = false
                    tooltip.dismissHandler = {
                        dismissIsCalled = true
                    }

                    //when
                    tooltip.show(in: targetView, within: childView)
                    tooltip.dismiss()

                    //then
                    expect(dismissIsCalled).toEventually(beTrue())
                }
            }

            context("Draw variants") {
                it("should draw with content") {

                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content")

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                    expect(tooltip.primaryAction).to(beNil())
                    expect(tooltip.secondaryAction).to(beNil())
                }

                it("should draw with content and title") {

                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content", title: "My title")

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                    expect(tooltip.primaryAction).to(beNil())
                    expect(tooltip.secondaryAction).to(beNil())
                }

                it("should dismiss tooltip") {

                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content", title: "My title")

                    //when
                    tooltip.show(in: targetView, within: childView)
                    tooltip.dismiss()

                    //then
                    expect(childView.subviews.filter { $0 is AndesBaseTooltipView }.first).toEventually(beNil())
                }

                it("should draw with content, title and clossable") {

                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content", title: "My title", isDismissable: true)

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                    expect(tooltip.primaryAction).to(beNil())
                    expect(tooltip.secondaryAction).to(beNil())
                }

                it("should draw with content, title, clossable, and loud action") {

                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content", title: "My title", isDismissable: true, primaryLoudAction: AndesTooltipAction(text: "my action", onPressed: {

                    }))

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                }

                it("should draw with content, title, clossable, and link action") {

                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content", title: "My title", isDismissable: true, linkAction: AndesTooltipAction(text: "my action", onPressed: {

                    }))

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                    expect(tooltip.primaryAction).notTo(beNil())
                    expect(tooltip.secondaryAction).to(beNil())
                }

                it("should draw with content, title, clossable, and quiet action") {

                    // given
                    let tooltip = AndesTooltip(lightStyle: "my content", title: "My title", isDismissable: true, primaryQuietAction: AndesTooltipAction(text: "my action", onPressed: {

                    }))

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                    expect(tooltip.primaryAction).notTo(beNil())
                    expect(tooltip.secondaryAction).to(beNil())
                }

                it("should draw with content, title, clossable, quiet primary and quiet secondary action") {

                    // given
                    let tooltip = AndesTooltip(lightStyle: "my content", title: "My title", isDismissable: true, primaryQuietAction: AndesTooltipAction(text: "my action", onPressed: {

                    }), secondaryQuietAction: AndesTooltipAction(text: "my action", onPressed: {

                    }))

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                    expect(tooltip.primaryAction).notTo(beNil())
                    expect(tooltip.secondaryAction).notTo(beNil())
                }

                it("should draw with content, title, clossable, loud primary and transparent secondary action") {

                    // given
                    let tooltip = AndesTooltip(type: .light, content: "my content", title: "My title", isDismissable: true, primaryLoudAction: AndesTooltipAction(text: "my action", onPressed: {

                    }), secondaryTransparentAction: AndesTooltipAction(text: "my action", onPressed: {

                    }))

                    //when
                    tooltip.show(in: targetView, within: childView)

                    let baseTooltipView = childView.subviews.filter { $0 is AndesBaseTooltipView }.first

                    //then
                    expect(baseTooltipView).notTo(beNil())
                    expect(tooltip.primaryAction).notTo(beNil())
                    expect(tooltip.secondaryAction).notTo(beNil())
                }
            }
        }
    }
}
