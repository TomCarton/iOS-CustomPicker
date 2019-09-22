//
//  CustomPicker.swift
//  CustomPicker
//
//  Created by Thomas CARTON
//

import UIKit

class CustomPicker: UIControl {
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let separatorView = UIView()

    private(set) var selectedIndex: Int?

    public func setSelectedIndex(_ index: Int?) {
        if shouldBeSelected, index == -1 {
            return
        }

        self.selectedIndex = index
        updateUI()

        sendActions(for: .valueChanged)
    }

    public var shouldBeSelected: Bool = true {
        didSet {
            if shouldBeSelected, selectedIndex == nil {
                self.selectedIndex = 0
                updateUI()
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            updateUI()
        }
    }

    var text1: String = "" {
        didSet {
            label1.text = text1
        }
    }

    var text2: String = "" {
        didSet {
            label2.text = text2
        }
    }

    var foregroundColor: UIColor = .blue {
        didSet {
            updateUI()
        }
    }

    override var backgroundColor: UIColor? {
        didSet {
            updateUI()
        }
    }

    var disabledColor: UIColor = .lightGray {
        didSet {
            updateUI()
        }
    }

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .white
        foregroundColor = .blue

        label1.textAlignment = .center
        label1.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label1)

        label2.textAlignment = .center
        label2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label2)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)

        layer.cornerRadius = 8.0
        layer.borderWidth = 2.0
        layer.masksToBounds = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)

        updateUI()
    }

    private func updateUI() {
        let foregroundColor = isEnabled ? foregroundColor : disabledColor
        layer.borderColor = foregroundColor.cgColor

        label1.font = selectedIndex == 0
                    ? UIFont.boldSystemFont(ofSize: label1.font.pointSize)
                    : UIFont.systemFont(ofSize: label1.font.pointSize)
        label1.backgroundColor = selectedIndex == 0 ? foregroundColor : backgroundColor
        label1.textColor = selectedIndex == 0 ? backgroundColor : foregroundColor

        label2.font = selectedIndex == 1
                    ? UIFont.boldSystemFont(ofSize: label2.font.pointSize)
                    : UIFont.systemFont(ofSize: label2.font.pointSize)
        label2.backgroundColor = selectedIndex == 1 ? foregroundColor : backgroundColor
        label2.textColor = selectedIndex == 1 ? backgroundColor : foregroundColor

        separatorView.backgroundColor = foregroundColor

        isUserInteractionEnabled = isEnabled
    }

    // MARK: - View Management

    override func layoutSubviews() {
        super.layoutSubviews()

        let halfWidth = bounds.width / 2
        let separatorWidth: CGFloat = 2.0

        label1.frame = CGRect(x: 0, y: 0, width: halfWidth - separatorWidth / 2, height: bounds.height)
        label2.frame = CGRect(x: halfWidth + separatorWidth / 2, y: 0, width: halfWidth - separatorWidth / 2, height: bounds.height)
        separatorView.frame = CGRect(x: halfWidth - separatorWidth / 2, y: 0, width: separatorWidth, height: bounds.height)

        bringSubviewToFront(separatorView)
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let halfWidth = bounds.width / 2
        let touchPoint = sender.location(in: self)

        let tappedIndex = touchPoint.x < halfWidth ? 0 : 1
        if let index = selectedIndex, tappedIndex == index, !shouldBeSelected {
            self.setSelectedIndex(nil)
        } else {
            self.setSelectedIndex(tappedIndex)
        }
    }
}
