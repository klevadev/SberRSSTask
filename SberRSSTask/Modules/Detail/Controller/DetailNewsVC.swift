//
//  DetailNewsVC.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import UIKit
import CoreData

class DetailNewsVC: UIViewController {
    
    // MARK: - Свойства
    private let detailView = DetailView()
    var viewModel: DetailsNewsViewModelProtocol!
    
    // MARK: - Функции
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        
        configureRSSItem()
    }
    
    private func configureViewComponents() {
        self.navigationItem.title = "Новость"
        view.backgroundColor = ThemeManager.Color.backgroundColor
        
        view.addSubview(detailView)
        
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        
        let navBarHeight = statusBarHeight + (navigationController?.navigationBar.frame.height ?? 0)
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(navBarHeight + 8)
            make.left.equalTo(view.snp.left).offset(8)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-8)
            
        }
    }
    
    private func configureRSSItem() {
        detailView.titleLabel.text = viewModel.title
        detailView.dateLabel.text = viewModel.date
        detailView.detailTextView.text = viewModel.description
    }    
}
