//
//  LoginInputView.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/28.
//

import Foundation
import UIKit

public class LoginInputView: UIView {
    public var placeHolder: String
    public init(placeHolder: String) {
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        configUI()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        lineView.backgroundColor = .black
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        lineView.backgroundColor = .lightGray
    }

    private func configUI() {
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.bottom.top.right.left.equalToSuperview()
        }
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(1)
            make.height.equalTo(0.5)
        }

        lineView.backgroundColor = .lightGray
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [
                                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                                                                NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }

    public var clearButtonMode: UITextField.ViewMode = .whileEditing {
        didSet {
            textField.clearButtonMode = clearButtonMode
        }
    }

    public var keyboardType: UIKeyboardType? {
        didSet {
            if let type = keyboardType {
                textField.keyboardType = type
            }
        }
    }

    public var text: String? {
        set {
            textField.text = newValue
        }
        get {
            return textField.text
        }
    }

    public var isShowSectureButton: Bool = false {
        didSet {
            if isShowSectureButton {
                clearButtonMode = .never
                addSubview(sectureButton)
                sectureButton.snp.makeConstraints { (make) in
                    make.right.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                textField.isSecureTextEntry = true
                sectureButton.addTarget(self, action: #selector(sectureButtonClick), for: .touchUpInside)
            }
        }
    }

    @objc private func sectureButtonClick() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        textField.becomeFirstResponder()
        if !textField.isSecureTextEntry {
            sectureButton.setImage(UIImage(named: "icon_20px_password_visible"), for: .normal)
        } else {
            sectureButton.setImage(UIImage(named: "icon_20px_password_invisible"), for: .normal)
        }
    }

    public let textField: UITextField = {
        let textfield = UITextField()
        textfield.clearButtonMode = .whileEditing
        textfield.textColor = .black
        return textfield
    }()

    private let lineView = UIView()
    private lazy var sectureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_20px_password_invisible"), for: .normal)
        return button
    }()
}
