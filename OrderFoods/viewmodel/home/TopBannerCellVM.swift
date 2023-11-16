//
//  TopBannerCellVM.swift
//  OrderFoods
//
//  Created by admin on 2023/11/16.
//

import Foundation
import RxSwift
import RxCocoa
class TopBannerCellVM{
    var bag: DisposeBag = DisposeBag()
    
    private let brand: BehaviorRelay<IndexBanner>
    
    init(brand: IndexBanner) {
        self.brand = BehaviorRelay(value: brand)
    }
}
// MARK: - 界面数据绑定
extension TopBannerCellVM{
    
    public var brandDriver: Driver<IndexBanner> {
        return brand.asDriver()
    }
    
    public var brandName: Driver<String> {
        return brandDriver.map {
            return $0.title
        }.asDriver()
    }
    
    public var brandID: Driver<String> {
        return brandDriver.map {
            return "\($0.adID)"
        }.asDriver()
    }
    public var brandLogo: Driver<URL?> {
        return brandDriver.map {
            return URL(string: $0.path) ?? nil
        }.asDriver()
    }
  
}
