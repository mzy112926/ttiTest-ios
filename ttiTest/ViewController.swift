//
//  ViewController.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/28.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configUI()
    }

    private func configUI() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(100)
        }
        view.addSubview(mobileView)
        mobileView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.height.equalTo(38)
        }
        mobileView.text = "appDevTest"
        view.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(mobileView.snp.bottom).offset(16)
            make.height.equalTo(38)
        }
        passwordView.text = "tti2020"
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(58)
            make.left.equalTo(32)
            make.right.equalTo(-32)
            make.height.equalTo(44)
        }
        loginButton.addTarget(self, action: #selector(loginInWithAccount), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldChanged), name: UITextField.textDidChangeNotification, object: mobileView.textField)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldChanged), name: UITextField.textDidChangeNotification, object: passwordView.textField)
    }

    @objc public func textFieldChanged() {
        let mobile = mobileView.text
        let password = passwordView.text

        if mobile?.count != 0 && password?.count != 0 {
            loginButton.isUserInteractionEnabled = true
        } else {
            loginButton.isUserInteractionEnabled = false
        }
    }

    @objc public func loginInWithAccount() {
        let account = mobileView.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = passwordView.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        guard let phone = account, phone.count != 0 else {
            return
        }
        guard let pword = password, !pword.isEmpty else {
            return
        }
        view.endEditing(true)
        loginWithUser(account: phone, password: pword)
    }

    @objc public func loginWithUser(account: String, password: String) {
        HttpManager().login(username: account, password: password, callback: { [weak self] status in
            guard let `self` = self else { return }
            if status {
                self.showList()
            }
        })
    }

    private func showList() {
        let controller = ProductListController()
        navigationController?.pushViewController(controller, animated: true)
    }

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26)
        label.text = "Login"
        return label
    }()

    fileprivate let mobileView: LoginInputView = {
        let view = LoginInputView(placeHolder: "your username")
        return view
    }()

    fileprivate let passwordView: LoginInputView = {
        let view = LoginInputView(placeHolder: "your password")
        view.isShowSectureButton = true
        return view
    }()

    fileprivate let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        return button
    }()
}

