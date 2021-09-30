//
//  ProductDetailViewController.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/29.
//

import UIKit

class ProductDetailViewController: UIViewController {

    let sku: String
    init(sku: String) {
        self.sku = sku
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "detail"
        configUI()
        loadDetail()
    }

    private func configUI() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(30 + 84)
        }
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        view.addSubview(createdLabel)
        createdLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
        }
        view.addSubview(updatedLabel)
        updatedLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(createdLabel.snp.bottom).offset(20)
        }
        view.addSubview(bookmarkButton)
        bookmarkButton.addTarget(self, action: #selector(bookmarkClick), for: .touchUpInside)
    }

    private func loadDetail() {
        HttpManager().productDetail(sku: sku) { [weak self] model in
            guard let `self` = self, let model = model else { return }
            self.nameLabel.text = model.name
            self.priceLabel.text = "price: " + "\(model.price)"
            self.createdLabel.text = "create: " + model.created_at
            self.updatedLabel.text = "update: " + model.updated_at
            self.bookmarkButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.updatedLabel.snp.bottom).offset(100)
            }
            self.buttonStatus()
        }
    }

    @objc private func bookmarkClick() {
        let status = UserDefaults.standard.bool(forKey: "bookmarked" + sku)
        UserDefaults.standard.setValue(!status, forKey: "bookmarked" + sku)
        buttonStatus()
    }

    private func buttonStatus() {
        bookmarkButton.setImage(UserDefaults.standard.bool(forKey: "bookmarked" + sku) ? UIImage(named: "bookmark") : UIImage(named: "unbookmark"), for: .normal)
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let createdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let updatedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let bookmarkButton: UIButton = {
        let button = UIButton()
        return button
    }()
}
