// The MIT License (MIT)
//
// Copyright (c) 2015 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

/// Used as an overlay on selected cells
class CheckmarkView: UIView {
    // MARK: - Instance variables

    var theme: Theme!

    var isSelected: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    // MARK: - Public

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }

    override func draw(_: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations

        //// Shadow Declarations
        let shadow2Offset = CGSize(width: 0.1, height: -0.1)
        let shadow2BlurRadius: CGFloat = 2.5

        //// Frames
        let checkmarkFrame = bounds

        //// Subframes
        let group = CGRect(
            x: checkmarkFrame.minX + 3,
            y: checkmarkFrame.minY + 3,
            width: checkmarkFrame.width - 6,
            height: checkmarkFrame.height - 6
        )

        //// CheckedOval Drawing
        let ovalRect = CGRect(
            x: group.minX + floor(group.width * 0.0 + 0.5),
            y: group.minY + floor(group.height * 0.0 + 0.5),
            width: floor(group.width * 1.0 + 0.5) - floor(group.width * 0.0 + 0.5),
            height: floor(group.height * 1.0 + 0.5) - floor(group.height * 0.0 + 0.5)
        )
        let checkedOvalPath = UIBezierPath(ovalIn: ovalRect)

        if isSelected {
            context?.saveGState()

            context?.setShadow(
                offset: shadow2Offset,
                blur: shadow2BlurRadius,
                color: theme.color.selectionShadow.cgColor
            )
            theme.color.selectionFill.setFill()
            checkedOvalPath.fill()
            context?.restoreGState()
        }

        theme.color.selectionStroke.setStroke()
        checkedOvalPath.lineWidth = 1
        checkedOvalPath.stroke()

        if isSelected {
            //// Check mark
            context?.setStrokeColor(theme.color.selectionStroke.cgColor)

            let checkPath = UIBezierPath()
            checkPath.move(to: CGPoint(x: 7, y: 12.5))
            checkPath.addLine(to: CGPoint(x: 11, y: 16))
            checkPath.addLine(to: CGPoint(x: 17.5, y: 9.5))
            checkPath.stroke()
        }
    }
}
