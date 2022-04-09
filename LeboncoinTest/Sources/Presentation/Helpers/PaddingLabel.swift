//
//  PaddingLabel.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

class PaddingLabel: UILabel {

    // MARK: - Properties

    var topInset: CGFloat
    var leftInset: CGFloat
    var bottomInset: CGFloat
    var rightInset: CGFloat

    // MARK: - Initializer

    required init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.topInset = top
        self.leftInset = left
        self.bottomInset = bottom
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += topInset + bottomInset
        contentSize.width += leftInset + rightInset

        return contentSize
    }
}
