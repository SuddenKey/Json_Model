//
//  HomeVC.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/22.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import SDCycleScrollView
import RxSwift
import RxCocoa
import MJRefresh


class HomeVC: YKFViewController, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate {
    
    let homeViewModel = HomeViewModel()
    
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN.width, height: SCREEN.height), style: UITableViewStyle.grouped)
    
    let bannerView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN.width, height: SCREEN.width*127/375))
    
    var bannerArray : Array<HomeBannerModel> = []
    var hospArray : Array<HomeHospModel> = []
    var newsModel = NewsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.bindViewModel()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUI() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = bannerView
        self.view.addSubview(self.tableView)
        self.bannerView.delegate = self
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.homeViewModel.refreshUI.onNext("")
        })
        
    }
    
    
    
    func bindViewModel() {
        homeViewModel.refreshSdcy.subscribe(onNext: { (dataArray) in
            self.bannerArray = dataArray
            var picArray : Array<String> = []
            for model in self.bannerArray {
                picArray.append(model.picUrl)
            }
            self.bannerView.imageURLStringsGroup = picArray
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        homeViewModel.refreshNearbyHosp.subscribe(onNext: { (dataArray) in
            self.hospArray = dataArray
            self.tableView.reloadData()
             self.tableView.mj_header.endRefreshing()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        homeViewModel.refreshNews.subscribe(onNext: { (model) in
            self.newsModel = model
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }
    
    // MARK: - tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            if self.newsModel.newsList.count < 3 {
                return self.newsModel.newsList.count
            }
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell : HomeFunctionCell! = nil
            if cell == nil {
                cell = HomeFunctionCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "HomeFunctionCell")
            }
            return cell
        } else if indexPath.section == 1 {
            var cell : HomeHospCell! = nil
            if cell == nil {
                cell = HomeHospCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "HomeHospCell")
            }
            cell.dataArray = hospArray
            return cell
        } else if indexPath.section == 2 {
            let cell = Bundle.main.loadNibNamed("HomeConsultingCell", owner: self, options: nil)?.first as! HomeConsultingCell
            cell.model(model: self.newsModel.newsList[indexPath.row])
            return cell
        }
        
        return YKFTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        } else if indexPath.section == 1 {
            return 157
        } else {
            return 87
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.homeViewModel.cellDiDsubject.onNext(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0.1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeHeaderView.init()
        if section == 0 {
            return UIView()
        } else if section == 1 {
            headerView.titleLB.text = "附近医院"
        } else if section == 2 {
            headerView.titleLB.text = "最新咨询"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = RGBCOLOR(r: 0.9166, g: 0.9166, b: 0.9166)
        return footerView
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func errorShow(objc: Any) {
//        super.errorShow(objc: objc)
//    }

}

class HomeHeaderView: UIView {
    let titleLB = UILabel.init(frame: CGRect.init(x: 30, y: 11, width: 117, height: 18))
    private let leftIcon = UIView.init(frame: CGRect.init(x: 15, y: 11, width: 2, height: 18))
    private let rightIcon = UIImageView.init(frame: CGRect.init(x: SCREEN.width - 28, y: 12, width: 8, height: 15))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        leftIcon.backgroundColor = HEXCOLOR(hexColor: "2189E9")
        self.addSubview(leftIcon)
        
        rightIcon.image = UIImage.init(named: "icon_hosp_index_right")
        self.addSubview(rightIcon)
        
        titleLB.textColor = HEXCOLOR(hexColor: "333333")
        titleLB.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(titleLB)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
