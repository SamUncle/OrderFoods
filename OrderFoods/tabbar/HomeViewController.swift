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
private let CellId: String = "MusicListCellId"

class HomeViewController: UIViewController,RequestEvent {
    func responseReturn(_ url: String, jsonStr: String) {
        Dlog(jsonStr)
    }
    

    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    fileprivate var didScroll: ((UIScrollView) -> ())?
    private var bag: DisposeBag = DisposeBag()
    
    private let viewModel = MusicListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("ffffff")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicViewCell.self, forCellReuseIdentifier: CellId)
        tableView.estimatedRowHeight = 95
        view.addSubview(tableView)
        let window = getCurrentWindow()
        let safeAreaTop = window.safeAreaInsets.top
        let safeAreaBottom = window.safeAreaInsets.bottom
        print("Safe Area Top: \(safeAreaTop)")
        print("Safe Area Bottom: \(safeAreaBottom)")
        if let tabBarHeight = self.tabBarController?.tabBar.frame.size.height {
            print("TabBar Height: \(tabBarHeight)")
            tableView.snp.makeConstraints { make in
                make.top.equalTo(view).offset(safeAreaTop)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-safeAreaBottom-tabBarHeight)
            }
        }
        tableView.separatorStyle = .none
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        let login = Login(email: "test@test.test", password: "testPassword")
//        AlamofireRequest.postParametersUrl(url: BASE_URL + "/post",parameters: login, delegate: self)
        viewModel.requestData()
        viewModel.dataSourceDriver.drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }).disposed(by: bag)
    }
}

func getCurrentWindow() -> UIWindow{
     
        if #available(iOS 13.0, *) {
            
            let array:Set = UIApplication.shared.connectedScenes
            
            let windowScene:UIWindowScene = array.first as! UIWindowScene
            
            //如果是普通App开发，可以使用
            
            //            SceneDelegate * delegate = (SceneDelegate *)windowScene.delegate;
            
            //            UIWindow * mainWindow = delegate.window;
            if let mainWindow:UIWindow = windowScene.value(forKeyPath:"delegate.window")as? UIWindow{
                return mainWindow
            }else{
                return UIApplication.shared.windows.first!
            }
        }else{
            return UIApplication.shared.keyWindow!
        }
    
}

 
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! MusicViewCell
        let cellViewModel = viewModel.dataSource[indexPath.row]
        cell.bind(viewModel: cellViewModel)
        return cell
    }
}

