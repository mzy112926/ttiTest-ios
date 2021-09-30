//
//  ProductListController.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/28.
//

import UIKit
import ESPullToRefresh

class ProductListController: UIViewController {
    private var products: [ProductModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "product list"
        configUI()
        configNav()
        loadData()
    }

    private func configUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(84)
        }
        tableView.register(ProductListTableCell.self, forCellReuseIdentifier: ProductListTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.es.addPullToRefresh { [weak self] in
            self?.loadData()
        }
    }

    private func configNav() {
        let reload = UIButton(type: .custom)
        reload.setTitle("reload", for: .normal)
        reload.setTitleColor(.darkGray, for: .normal)
        reload.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        let reloadItem = UIBarButtonItem(customView: reload)
        reload.addTarget(self, action: #selector(reloadClick), for: .touchUpInside)

        let reloadSpaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        reloadSpaceItem.width = 20

        let sort = UIButton(type: .custom)
        sort.setTitle("sort", for: .normal)
        sort.setTitleColor(.darkGray, for: .normal)
        sort.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let sortItem = UIBarButtonItem(customView: sort)
        sort.addTarget(self, action: #selector(sortClick), for: .touchUpInside)

        navigationItem.rightBarButtonItems = [reloadItem, reloadSpaceItem, sortItem]
    }

    private func loadData() {
        HttpManager().products(pageSize: 20) { [weak self] (status, datas) in
            guard let `self` = self else { return }
            self.products = datas
            self.tableView.reloadData()
            self.tableView.es.stopPullToRefresh()
        }
    }

    @objc private func reloadClick() {
        tableView.es.startPullToRefresh()
    }

    @objc private func sortClick() {
        products = products.sorted(by: { p1, p2 in
            return p1.name.localizedStandardCompare(p2.name) == ComparisonResult.orderedAscending
        })
        tableView.reloadData()
    }

    private let tableView: UITableView = {
        let tab = UITableView()
        return tab
    }()
}

extension ProductListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductListTableCell = tableView.dequeueReusableCell(withIdentifier: ProductListTableCell.identifier, for: indexPath) as! ProductListTableCell
        cell.model = products[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProductDetailViewController(sku: products[indexPath.row].sku)
        navigationController?.pushViewController(controller, animated: true)
    }
}
