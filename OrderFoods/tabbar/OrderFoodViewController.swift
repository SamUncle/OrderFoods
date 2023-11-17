//
//  OrderFoodViewController.swift
//  OrderFoods
//
//  Created by admin on 2023/11/16.
//
import SnapKit
import JXBanner
import JXPageControl

class OrderFoodViewController: UIViewController {

    var pageCount = 5

    lazy var linearBanner: JXBanner = {[weak self] in
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.backgroundColor = UIColor.groupTableViewBackground
        banner.indentify = "linearBanner"
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()

    lazy var converflowBanner: JXBanner = {
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.backgroundColor = UIColor.groupTableViewBackground
//        banner.indentify = "converflowBanner"
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(linearBanner)
//        view.addSubview(converflowBanner)
//        linearBanner.snp.makeConstraints {(maker) in
//            maker.left.right.equalTo(view)
//            maker.height.equalTo(200)
//            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//        }
        

//        converflowBanner.snp.makeConstraints {(maker) in
//            maker.left.right.height.equalTo(linearBanner)
//            maker.top.equalTo(linearBanner.snp.bottom).offset(100)
//        }

        
    }

    deinit {
        debugPrint("\(#function) ----------> \(#file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? #file)")
    }
}

// MARK: -- JXBannerDataSource
extension OrderFoodViewController: JXBannerDataSource {

    // 注册重用Cell标识
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {

        if banner.indentify == "linearBanner" {
            return JXBannerCellRegister(type: JXBannerCell.self,
                reuseIdentifier: "LinearBannerCell")
        }else {
            return JXBannerCellRegister(type: JXBannerCell.self,
            reuseIdentifier: "ConverflowBannerCell")
        }
    }

    // 轮播总数
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return pageCount }

    // 轮播cell内容设置
    func jxBanner(_ banner: JXBannerType,
        cellForItemAt index: Int,
        cell: UICollectionViewCell)
        -> UICollectionViewCell {
            let tempCell: JXBannerCell = cell as! JXBannerCell
            tempCell.layer.cornerRadius = 8
            tempCell.layer.masksToBounds = true
            tempCell.imageView.image = UIImage(named: "banner_placeholder")
            tempCell.imageView.contentMode = .scaleAspectFill
            tempCell.msgBgView.isHidden = true
//            tempCell.msgLabel.text = String(index) + "---来喽来喽,他真的来喽~"
            return tempCell
    }

    // banner基本设置（可选）
    func jxBanner(_ banner: JXBannerType,
        params: JXBannerParams)
        -> JXBannerParams {

        if banner.indentify == "linearBanner" {
            return params
                .timeInterval(2)
                .cycleWay(.forward)
        }else {
            return params.isAutoPlay(false)
                .timeInterval(3)
                .cycleWay(.forward)
        }
    }

// banner布局、动画设置
    func jxBanner(_ banner: JXBannerType,
        layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {

        if banner.indentify == "linearBanner" {
            return layoutParams
                .layoutType(JXBannerTransformLinear())
                .itemSize(CGSize(width: 280, height: 190))
                .itemSpacing(20)
                .rateOfChange(0.8)
                .minimumScale(0.7)
                .rateHorisonMargin(0.5)
                .minimumAlpha(0.8)
        }else {
            return layoutParams
                .layoutType(JXBannerTransformCoverflow())
                .itemSize(CGSize(width: 300, height: 190))
                .itemSpacing(10)
                .maximumAngle(0.25)
                .rateHorisonMargin(0.3)
                .minimumAlpha(0.8)
        }
    }

    // 自定义pageControl样式、布局
    //（基于jxPageControl, 如果不适用JXPageControl, 设置isShowPageControl = false， 内部pageControl将不会再次加载 ）
    func jxBanner(pageControl banner: JXBannerType,
        numberOfPages: Int,
        coverView: UIView,
        builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {

            if banner.indentify == "linearBanner" {
                let pageControl = JXPageControlJump()
                pageControl.contentMode = .bottom
                pageControl.activeSize = CGSize(width: 15, height: 6)
                pageControl.inactiveSize = CGSize(width: 6, height: 6)
                pageControl.activeColor = UIColor.red
                pageControl.inactiveColor = UIColor.groupTableViewBackground
                pageControl.columnSpacing = 0
                pageControl.isAnimation = true
                builder.pageControl = pageControl
                builder.layout = {
                    pageControl.snp.makeConstraints { (maker) in
                        maker.left.right.equalTo(coverView)
                        maker.top.equalTo(coverView.snp.bottom).offset(5)
                        maker.height.equalTo(10)
                    }
                }
                return builder

            }else {
                let pageControl = JXPageControlExchange()
                pageControl.contentMode = .bottom
                pageControl.activeSize = CGSize(width: 15, height: 6)
                pageControl.inactiveSize = CGSize(width: 6, height: 6)
                pageControl.activeColor = UIColor.red
                pageControl.inactiveColor = UIColor.groupTableViewBackground
                pageControl.columnSpacing = 0
                builder.pageControl = pageControl
                builder.layout = {
                    pageControl.snp.makeConstraints { (maker) in
                        maker.left.right.equalTo(coverView)
                        maker.top.equalTo(coverView.snp.bottom).offset(10)
                        maker.height.equalTo(20)
                    }
                }
                return builder
        }

    }

}

//MARK:- JXBannerDelegate
extension OrderFoodViewController: JXBannerDelegate {

    // 点击cell回调
    public func jxBanner(_ banner: JXBannerType,
        didSelectItemAt index: Int) {
        debugPrint("点击：\(index)")
    }

    // 设置自定义覆盖View, 比如添加自定义外部pageControl和布局
    func jxBanner(_ banner: JXBannerType, coverView: UIView) {
//        let title = UILabel()
//        title.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
//        title.text = "JXBanner"
//        title.textColor = UIColor.red
//        title.font = UIFont.systemFont(ofSize: 16)
//        coverView.addSubview(title)
    }

    // 最中心显示cell 索引
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        debugPrint(index)
    }
}

