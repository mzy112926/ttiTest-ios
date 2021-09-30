//
//  ProductListTableCell.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/28.
//

import UIKit

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

class ProductListTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(16)
            make.width.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: ProductModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.name
            priceLabel.text = "\(model.price)"
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
}
