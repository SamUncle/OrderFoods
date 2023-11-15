//
//  SamNetWork.swift
//  OrderFoods
//
//  Created by admin on 2023/11/14.
//

import Foundation
import Moya

let ApiProvider = MoyaProvider<SamApiManager>(plugins: [NetworkLoggerPlugin()])

enum SamApiManager {
    case whpHost
    case post(page:Int)
    case music(page: Int)
    case createUser(firstName: String, lastName: String)
    
}
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
extension SamApiManager: TargetType {
    var baseURL: URL {
        switch self {
        case .whpHost:
            return URL(string: "https://hzx.whirlpool-china.com:7005")!
        default:
            return URL(string: "https://httpbin.org")!
        }
        
    }
    
    var path: String {
        switch self {
        case .whpHost:
            return "/m/new_index.jhtml"
        case .post:
            return "/post"
        case .music:
            return "/m/new_index.jhtml"
        case .createUser(_, _):
            return "/post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .whpHost:
            return .post
            
        default:
            return .post
        }
        
    }
    
//    var sampleData: Data {
//        switch self {
//        case .createUser(let firstName, let lastName):
//            return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
//        case .get:
//            return stubbedResponse("Feed")
//        case .post(let page):
//            print("post请求 \(page)")
//            return stubbedResponse("UserMusicList")
//        case .music(let page):
//            print("请求参数：\(page)")
//            return stubbedResponse("UserMusicList")
//
//        }
//    }
    
    var task: Task {
        switch self {
        case .whpHost:
            let whp_para = ["version":"1.0","devid":"惠而浦商城","company_info_id":1,"language":"zh"] as [String : Any]
            return NetReqUtil.urlRequestParameters(para: whp_para)
            
        case let .post(page):
            return .requestParameters(parameters: ["page":page], encoding: JSONEncoding.default)
            
        case let .createUser(firstName, lastName):
            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        default:
            return .requestPlain
            
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .whpHost:
             return ["User-Agent":"android;"]
        default:
            return nil
        }
        //        return ["User-Agent":"ios"]
    }
    
    func stubbedResponse(_ filename: String) -> Data {
        guard FileManager.fileExistInMainBundle(fileName: "\(filename).json") else { return Data([]) }
        guard let path = Bundle.main.url(forResource: filename, withExtension: "json") else { return Data([]) }
        guard let data = try? Data(contentsOf: path) else { return Data([]) }
        return data
    }
}

