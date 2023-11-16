//
//  TopBrandViewCell.swift
//  OrderFoods
//
//  Created by admin on 2023/11/16.
//
import SnapKit
import RxSwift
import RxCocoa
import Moya
import JXBanner
import JXPageControl
import Kingfisher
class TopBrandViewCell: UITableViewCell {
    var pageCount = 5
    private var bag: DisposeBag = DisposeBag()
    private var brandImageV: UIImageView!
    var dataSource = [TopBannerCellVM]()
//    let viewModel =
    lazy var linearBanner: JXBanner = {[weak self] in
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.backgroundColor = UIColor.systemGray4
        banner.indentify = "linearBanner"
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.white
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bag = DisposeBag()
    }
    func setUpUI(){
        contentView.addSubview(linearBanner)
        let w_h_sacle:CGFloat = 327/136
        let banner_height = (UIScreen.main.bounds.width - 69) / w_h_sacle + 28
//        return CGSize.init(w: SCREEN_W, h:banner_height)
        linearBanner.snp.makeConstraints {(maker) in
            maker.left.right.equalToSuperview()
            maker.height.equalTo(banner_height)
            maker.top.equalToSuperview()
        }
    }
    //数据绑定
    func bind(viewModels: [TopBannerCellVM]) {
        dataSource = viewModels
        self.linearBanner.reloadView()
    }
    
}
// MARK: -- JXBannerDataSource
extension TopBrandViewCell: JXBannerDataSource {
    
    // 注册重用Cell标识
    func jxBanner(_ banner: JXBannerType)
    -> (JXBannerCellRegister) {
        return JXBannerCellRegister(type: JXBannerCell.self,
                                    reuseIdentifier: "LinearBannerCell")
        
    }
    
    // 轮播总数
    func jxBanner(numberOfItems banner: JXBannerType)
    -> Int { return dataSource.count }
    
    // 轮播cell内容设置
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: UICollectionViewCell)
    -> UICollectionViewCell {
        let tempCell: JXBannerCell = cell as! JXBannerCell
        tempCell.layer.cornerRadius = 8
        tempCell.layer.masksToBounds = true
//        tempCell.imageView.image = UIImage(named: "banner_placeholder")
        let model = dataSource[index] as TopBannerCellVM
        model.brandLogo.drive(onNext: { url in
            tempCell.imageView.kf.setImage(with: url)
        }).disposed(by: bag)
        
        tempCell.imageView.contentMode = .scaleAspectFit
        tempCell.msgBgView.isHidden = true
        return tempCell
    }
    
    // banner基本设置（可选）
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams)
    -> JXBannerParams {
        return params
            .timeInterval(2)
            .cycleWay(.forward)
    
    }
    
    // banner布局、动画设置
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
    -> JXBannerLayoutParams {
        let w_h_sacle:CGFloat = 327/136
        let banner_height = (UIScreen.main.bounds.width) / w_h_sacle + 28
        
        return layoutParams
//            .layoutType(JXBannerTransformLinear())
            .itemSize(CGSize(width: UIScreen.main.bounds.width, height: banner_height))
            .itemSpacing(20)
//            .rateOfChange(1)
//            .minimumScale(0.7)
//            .rateHorisonMargin(0.5)
//            .minimumAlpha(0.8)
        
    }
    
    // 自定义pageControl样式、布局
    //（基于jxPageControl, 如果不适用JXPageControl, 设置isShowPageControl = false， 内部pageControl将不会再次加载 ）
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  coverView: UIView,
                  builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
        
        let pageControl = JXPageControlJump()
        pageControl.contentMode = .bottom
        pageControl.activeSize = CGSize(width: 15, height: 6)
        pageControl.inactiveSize = CGSize(width: 6, height: 6)
        pageControl.activeColor = UIColor.red
        pageControl.inactiveColor = UIColor.systemGray2
        pageControl.columnSpacing = 0
        pageControl.isAnimation = true
        builder.pageControl = pageControl
        builder.layout = {
            pageControl.snp.makeConstraints { (maker) in
                maker.left.right.equalTo(coverView)
                maker.top.equalTo(coverView.snp.bottom).offset(-15)
                maker.height.equalTo(10)
            }
        }
        return builder
    }
    
}

//MARK: - JXBannerDelegate
extension TopBrandViewCell: JXBannerDelegate {
    
    // 点击cell回调
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        debugPrint("点击：\(index)")
        let model = dataSource[index] as TopBannerCellVM
        model.brandID.drive(onNext: { id in
            debugPrint(id)
        }).disposed(by: bag)
    }
    
    // 最中心显示cell 索引
    func jxBanner(_ banner: JXBannerType, center index: Int) {
//        debugPrint(index)
    }
}
