//
//  HomeViewModel.swift
//  OrderFoods
//
//  Created by admin on 2023/11/15.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
class HomeViewModel {
    let disposeBag = DisposeBag()
    private var brandDataSource: BehaviorRelay<[IndexBrandCellViewModel]> = BehaviorRelay(value: [])
    
    public var dataSourceDriver: Driver<[IndexBrandCellViewModel]> {
        return brandDataSource.asDriver()
    }
    public var dataSource: [IndexBrandCellViewModel] {
        return brandDataSource.value
    }
    
    func requestData() {
//        ApiProvider.request(.whpHost) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let filteredResponse = try response.filterSuccessfulStatusCodes()
//                    let home = try filteredResponse.map(WhpHome.self)
//                    debugPrint(home.categoryMap.channelName)
//                }
//                catch let error {
//                    debugPrint(error)
//                }
//                //自定义解析response 成 json字符串
////                let data = response.data
////                let statusCode = response.statusCode
////                let dataString = String(data: data, encoding: .utf8)
////                debugPrint("request success : \(statusCode) \(String(describing: dataString))")
//            case let .failure(err):
//                debugPrint("request fail :\(err)")
//            }
//        }
 
        //rxswift 解析 全部解析
//        ApiProvider.rx.request(.whpHost).filterSuccessfulStatusCodes().map(WhpHome.self).subscribe { res in
//            switch res {
//            case .success(let http):
//                debugPrint(http.categoryMap.channelName)
//            case .failure(let err):
//                debugPrint(err)
//            }
//        }
        //rxswift 指定字段解析 这里指定品牌数组字段‘index_brand’
        ApiProvider.rx.request(.whpHost).filterSuccessfulStatusCodes().map([IndexBrand].self,atKeyPath: "index_brand",failsOnEmptyData: false).subscribe { [weak self] brands in
            switch brands {
            case .success(let data):
                
                self?.brandDataSource.accept(data.map{
                    IndexBrandCellViewModel(brand: $0)
                })
                debugPrint(data)
            case .failure(let err):
                debugPrint(err)
            }
        }.disposed(by: disposeBag)
    }
}
