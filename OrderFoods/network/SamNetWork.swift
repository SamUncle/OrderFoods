//
//  SamNetWork.swift
//  OrderFoods
//
//  Created by admin on 2023/11/14.
//

import Foundation
import Moya
//正式请求(不使用sampleData)
let ApiProvider = MoyaProvider<ApiServiceManager>(plugins: [NetworkLoggerPlugin()])
//使用sampleData
let SampleApiProvider =  MoyaProvider<ApiServiceManager>(stubClosure: MoyaProvider.delayedStub(2) ,plugins: [NetworkLoggerPlugin()])
enum ApiServiceManager {
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
extension ApiServiceManager: TargetType {
    var baseURL: URL {
        switch self {
        case .whpHost:
            return URL(string: "https://hzx.whirlpool-china.com:7005")!
        case .music:
            return URL(string: "https://aweme-eagle-hl.snssdk.com")!
        default:
            return URL(string: "https://httpbin.or")!
        }
        
    }
    
    var path: String {
        switch self {
        case .whpHost:
            return "/m/new_index.jhtml"
        case .post:
            return "/post"
        case .music:
            return "/aweme/v1/original/music/list/"
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
    
    var sampleData: Data {
        switch self {
        case .createUser(let firstName, let lastName):
            return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
        case .whpHost:
            return stubbedResponse("UserMusicList")
        
        default:
            return stubbedResponse("UserMusicList")
        }
    }
    
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

