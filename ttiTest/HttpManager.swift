//
//  HttpManager.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/28.
//

import Foundation
import Alamofire

let address = "https://milwaukee.dtndev.com/rest/default/V1/"

class HttpManager {

    func login(username: String, password: String, callback: @escaping((Bool) -> Void)) {
        let parameters: Parameters = ["username": username, "password": password]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "accept": "application/json"
        ]
        AF.request(address + "integration/admin/token", method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .responseString { response in
                if response.error != nil {
                    callback(false)
                } else {
                    if let token = response.value {
                        let t = token.replacingOccurrences(of: "\"", with: "")
                        UserDefaults.standard.setValue(t, forKey: "userToken")
                        callback(true)
                    } else {
                        callback(false)
                    }
                }
            }
    }

    func products(pageSize: Int, callback: @escaping((Bool, [ProductModel]) -> Void)) {
        let parameters: Parameters = ["searchCriteria[pageSize]": pageSize]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer " + (UserDefaults.standard.value(forKey: "userToken") as! String)
        ]
        AF.request(address + "products", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseJSON(completionHandler: { response in
                if response.error != nil {
                    callback(false, [])
                } else {
                    if let dic = response.value as? [String: Any], let items = dic["items"] as? [[String: Any]] {
                        var datas: [ProductModel] = []
                        items.forEach { dict in
                            datas.append(ProductModel.deserialize(from: dict)!)
                        }
                        callback(true, datas)
                    } else {
                        callback(false, [])
                    }
                }
            })
    }

    func productDetail(sku: String, callback: @escaping((ProductModel?) -> Void)) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer " + (UserDefaults.standard.value(forKey: "userToken") as! String)
        ]
        let sku1 = sku.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        AF.request(address + "products/" + sku1, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON(completionHandler: { response in
                if response.error != nil {
                    callback(nil)
                } else {
                    if let dic = response.value as? [String: Any], let model = ProductModel.deserialize(from: dic) {
                        callback(model)
                    } else {
                        callback(nil)
                    }
                }
            })
    }
}
