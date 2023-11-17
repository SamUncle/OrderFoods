//
//  HomeViewController.swift
//  OrderFoods
//
//  Created by admin on 2023/11/14.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import NSObject_Rx
import MJRefresh
private let IndexBrandViewCellId:String = "IndexBrandViewCell"
private let TopBrandViewCellId:String = "TopBrandViewCell"
class HomeViewController: UIViewController,RequestEvent {
    //自定义网络请求回调实现
    func responseReturn(_ url: String, jsonStr: String) {
        Dlog(jsonStr)
    }
    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    fileprivate var didScroll: ((UIScrollView) -> ())?
    private var bag: DisposeBag = DisposeBag()
    private let homeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = UIColor("f7f7f7")
        tableView.backgroundColor = UIColor("f7f7f7")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IndexBrandViewCell.self, forCellReuseIdentifier: IndexBrandViewCellId)
        tableView.register(TopBrandViewCell.self, forCellReuseIdentifier: TopBrandViewCellId)
        tableView.estimatedRowHeight = 95
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        self.addRefreshHeader()
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        //        let login = Login(email: "test@test.test", password: "testPassword")
        //        AlamofireRequest.postParametersUrl(url: BASE_URL + "/post",parameters: login, delegate: self)
        self.homeViewModel.requestData()
        self.homeViewModel.dataSourceDriver.drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.tableView.reloadData()
            self.tableView.mj_header?.endRefreshing()
        }).disposed(by: self.bag)
    }
    //下拉刷新
    func addRefreshHeader() {
        let header = MJRefreshNormalHeader { [weak self] in
            self?.homeViewModel.requestData()
        }
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
//        let image = UIImage.init(systemName: "arrow.down")
//        header.arrowView?.image = image
        header.stateLabel?.textColor = .red
        if #available(iOS 13.0, *) {
            header.loadingView?.style = UIActivityIndicatorView.Style.medium
        } else {
            
        }
        header.loadingView?.color = .red
        header
            .autoChangeTransparency(true)
            .link(to: tableView)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let w_h_sacle:CGFloat = 327/136
            let banner_height = (UIScreen.main.bounds.width) / w_h_sacle + 28
            return banner_height
        case 1:
            return 80
        default:
            return 85
        }
        
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeViewModel.dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopBrandViewCellId, for: indexPath) as! TopBrandViewCell
            let cellViewModel = homeViewModel.topBannerDataSourceV
            cell.bind(viewModels: cellViewModel)
            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: IndexBrandViewCellId, for: indexPath) as! IndexBrandViewCell
//            let cellViewModel = homeViewModel.dataSource[indexPath.row-1]
//            cell.bind(viewModel: cellViewModel)
//            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: IndexBrandViewCellId, for: indexPath) as! IndexBrandViewCell
            let cellViewModel = homeViewModel.dataSource[indexPath.row-1]
            cell.bind(viewModel: cellViewModel)
            return cell
        }
        
    }
}

