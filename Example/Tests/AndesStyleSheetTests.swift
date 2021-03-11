//
//  AndesStyleSheetTests.swift
//  AndesUI_Tests
//
//  Created by LEANDRO FURYK on 26/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
import AndesUI

class AndesStyleSheetTests: QuickSpec {
    override func spec() {
        describe("AndesStyleSheetManager should be able to be configured") {

            context("AndesStyleSheet has not been provided to Manager") {
                it("should use the default one") {
                    let styleSheetDefault = AndesStyleSheetDefault()
                    expect(self.compareStyleSheets(styleSheetOne: AndesStyleSheetManager.styleSheet, styleSheetTwo: styleSheetDefault)).to(beTrue())
                }
            }

            context("changing AndesStyleSheet") {
                it("should provide different colors") {
                    let firstStylesheet = AndesStyleSheetWhiteMock()
                    AndesStyleSheetManager.styleSheet = firstStylesheet

                    expect(self.compareStyleSheets(styleSheetOne: AndesStyleSheetManager.styleSheet, styleSheetTwo: firstStylesheet)).to(beTrue())

                    //Then change it
                    let secondStylesheet = AndesStyleSheetBlackMock()
                    AndesStyleSheetManager.styleSheet = secondStylesheet

                    expect(self.compareStyleSheets(styleSheetOne: AndesStyleSheetManager.styleSheet, styleSheetTwo: firstStylesheet)).to(beFalse())

                    expect(self.compareStyleSheets(styleSheetOne: AndesStyleSheetManager.styleSheet, styleSheetTwo: secondStylesheet)).to(beTrue())
                }
            }
        }
    }

    private func compareStyleSheets(styleSheetOne: AndesStyleSheet, styleSheetTwo: AndesStyleSheet) -> Bool {

        var equal = true

        equal = equal && styleSheetOne.brandColor500.isEqual(styleSheetTwo.brandColor500)

        equal = equal && styleSheetOne.accentColor.isEqual(styleSheetTwo.accentColor)
        equal = equal && styleSheetOne.accentColor100.isEqual(styleSheetTwo.accentColor100)
        equal = equal && styleSheetOne.accentColor200.isEqual(styleSheetTwo.accentColor200)
        equal = equal && styleSheetOne.accentColor300.isEqual(styleSheetTwo.accentColor300)
        equal = equal && styleSheetOne.accentColor400.isEqual(styleSheetTwo.accentColor400)
        equal = equal && styleSheetOne.accentColor500.isEqual(styleSheetTwo.accentColor500)
        equal = equal && styleSheetOne.accentColor600.isEqual(styleSheetTwo.accentColor600)
        equal = equal && styleSheetOne.accentColor700.isEqual(styleSheetTwo.accentColor700)
        equal = equal && styleSheetOne.accentColor800.isEqual(styleSheetTwo.accentColor800)

        equal = equal && styleSheetOne.bgColorPrimary.isEqual(styleSheetTwo.bgColorPrimary)
        equal = equal && styleSheetOne.bgColorWhite.isEqual(styleSheetTwo.bgColorWhite)
        equal = equal && styleSheetOne.bgColorSecondary.isEqual(styleSheetTwo.bgColorSecondary)

        equal = equal && styleSheetOne.tetColorLink.isEqual(styleSheetTwo.tetColorLink)
        equal = equal && styleSheetOne.textColorLink.isEqual(styleSheetTwo.textColorLink)
        equal = equal && styleSheetOne.textColorCaution.isEqual(styleSheetTwo.textColorCaution)
        equal = equal && styleSheetOne.textColorWhite.isEqual(styleSheetTwo.textColorWhite)
        equal = equal && styleSheetOne.textColorPrimary.isEqual(styleSheetTwo.textColorPrimary)
        equal = equal && styleSheetOne.textColorSecondary.isEqual(styleSheetTwo.textColorSecondary)
        equal = equal && styleSheetOne.textColorDisabled.isEqual(styleSheetTwo.textColorDisabled)
        equal = equal && styleSheetOne.textColorNegative.isEqual(styleSheetTwo.textColorNegative)
        equal = equal && styleSheetOne.textColorPositive.isEqual(styleSheetTwo.textColorPositive)

        equal = equal && styleSheetOne.titleXL(color: styleSheetOne.textColorPrimary).compare(object: (styleSheetTwo.titleXL(color: styleSheetTwo.textColorPrimary)))
        equal = equal && styleSheetOne.titleL(color: styleSheetOne.textColorPrimary).compare(object: (styleSheetTwo.titleL(color: styleSheetTwo.textColorPrimary)))
        equal = equal && styleSheetOne.titleM(color: styleSheetOne.textColorPrimary).compare(object: (styleSheetTwo.titleM(color: styleSheetTwo.textColorPrimary)))
        equal = equal && styleSheetOne.titleS(color: styleSheetOne.textColorPrimary).compare(object: (styleSheetTwo.titleS(color: styleSheetTwo.textColorPrimary)))

        equal = equal && styleSheetOne.bodyXS(color: styleSheetOne.textColorPrimary).compare(object: (styleSheetTwo.bodyXS(color: styleSheetTwo.textColorPrimary)))
        equal = equal && styleSheetOne.bodyL(color: styleSheetOne.textColorPrimary).compare(object: (styleSheetTwo.bodyL(color: styleSheetTwo.textColorPrimary)))
        equal = equal && styleSheetOne.bodyM(color: styleSheetOne.textColorPrimary).compare(object: (styleSheetTwo.bodyM(color: styleSheetTwo.textColorPrimary)))

        equal = equal && styleSheetOne.regularSystemFont(size: 1).isEqual(styleSheetTwo.regularSystemFont(size: 1))
        equal = equal && styleSheetOne.lightSystemFont(size: 1).isEqual(styleSheetTwo.lightSystemFont(size: 1))
        equal = equal && styleSheetOne.mediumSystemFontOfSize(size: 1).isEqual(styleSheetTwo.mediumSystemFontOfSize(size: 1))
        equal = equal && styleSheetOne.semiboldSystemFontOfSize(size: 1).isEqual(styleSheetTwo.semiboldSystemFontOfSize(size: 1))

        return equal
    }
}

extension AndesFontStyle {
    public func compare(object: AndesFontStyle) -> Bool {
        var equal = self.textColor.isEqual(object.textColor)
        equal = equal && self.font.isEqual(object.font)
        return equal && self.lineHeight.isEqual(to: object.lineHeight)
    }
}

class AndesStyleSheetWhiteMock: AndesStyleSheet {

    var bgColorPrimary: UIColor = .white

    var bgColorSecondary: UIColor = .white

    var bgColorWhite: UIColor = .white

    var brandColor500: UIColor = .white

    var accentColor: UIColor = .white

    var accentColor100: UIColor = .white

    var accentColor150: UIColor = .white

    var accentColor200: UIColor = .white

    var accentColor300: UIColor = .white

    var accentColor400: UIColor = .white

    var accentColor500: UIColor = .white

    var accentColor600: UIColor = .white

    var accentColor700: UIColor = .white

    var accentColor800: UIColor = .white

    var textColorPrimary: UIColor = .white

    var textColorSecondary: UIColor = .white

    var textColorDisabled: UIColor = .white

    var textColorNegative: UIColor = .white

    var textColorCaution: UIColor = .white

    var textColorPositive: UIColor = .white

    var tetColorLink: UIColor = .white

    var textColorLink: UIColor = .white

    var textColorWhite: UIColor = .white

    var feedbackColorNegative: UIColor = .white

    var feedbackColorCaution: UIColor = .white

    var feedbackColorPositive: UIColor = .white

    var feedbackColorWarning: UIColor = .white

    var textColorWarning: UIColor = .white

    func titleXS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyXS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleXL(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleL(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleM(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyL(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyM(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    var mockAndesFontStyle: AndesFontStyle = AndesFontStyle(textColor: .white, font: UIFont.boldSystemFont(ofSize: 1), lineHeight: 1)

    public func regularSystemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func lightSystemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func mediumSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func semiboldSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
}

class AndesStyleSheetBlackMock: AndesStyleSheet {
    var textColorWarning: UIColor = .black

    var feedbackColorWarning: UIColor = .black

    var bgColorPrimary: UIColor = .black

    var bgColorSecondary: UIColor = .black

    var bgColorWhite: UIColor = .black

    var brandColor500: UIColor = .black

    var accentColor: UIColor = .black

    var accentColor100: UIColor = .black

    var accentColor150: UIColor = .black

    var accentColor200: UIColor = .black

    var accentColor300: UIColor = .black

    var accentColor400: UIColor = .black

    var accentColor500: UIColor = .black

    var accentColor600: UIColor = .black

    var accentColor700: UIColor = .black

    var accentColor800: UIColor = .black

    var textColorPrimary: UIColor = .black

    var textColorSecondary: UIColor = .black

    var textColorDisabled: UIColor = .black

    var textColorNegative: UIColor = .black

    var textColorCaution: UIColor = .black

    var textColorPositive: UIColor = .black

    var tetColorLink: UIColor = .black

    var textColorLink: UIColor = .black

    var textColorWhite: UIColor = .black

    var feedbackColorNegative: UIColor = .black

    var feedbackColorCaution: UIColor = .black

    var feedbackColorPositive: UIColor = .black

   func titleXS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyXS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleXL(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleL(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleM(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func titleS(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyL(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    func bodyM(color: UIColor) -> AndesFontStyle {
        return mockAndesFontStyle
    }

    var mockAndesFontStyle: AndesFontStyle = AndesFontStyle(textColor: .black, font: UIFont.boldSystemFont(ofSize: 2), lineHeight: 2)

    public func regularSystemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func lightSystemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func mediumSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func semiboldSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
}
