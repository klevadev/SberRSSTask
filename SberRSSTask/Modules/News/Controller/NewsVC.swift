//
//  NewsVC.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import UIKit
import CoreData

class NewsVC: UIViewController {
    
    // MARK: - Свойства
    var viewModel: NewsVCViewModelProtocol!
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var refreshControl = UIRefreshControl()
    
    private let emptyNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "Не удалось загрузить новости\n по текущуему адресу"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyNewsImage: UIImageView = {
        let image = #imageLiteral(resourceName: "not-found")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ThemeManager.Color.backgroundColor
        setupTableView()
    }
    // MARK: - Функции
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = NewsVCViewModel()
        updateNews()
    }
    
    private func updateNews() {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            refreshControl.beginRefreshing()
            view.isUserInteractionEnabled = false
            viewModel.fetchNewsFromInternet {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            view.isUserInteractionEnabled = true
            refreshControl.endRefreshing()
        } else {
            print("Internet Connection not Available!")
            viewModel.fetchNewsFromCoreData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.saveNewsToCoreData()
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        updateNews()
    }

    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)

        tableView.addSubview(refreshControl)
        tableView.addSubview(emptyNewsLabel)
        tableView.addSubview(emptyNewsImage)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseId)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните для обновления")
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        setupConstraints()
    }
    
    // Установка Constraint для UITableView
    private func setupConstraints() {
        tableView.fillToSuperView(view: view)
        
        emptyNewsLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptyNewsLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 50).isActive = true

        emptyNewsImage.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptyNewsImage.topAnchor.constraint(equalTo: emptyNewsLabel.bottomAnchor, constant: 25).isActive = true
    }
}
//MARK:- UITableViewDataSource
extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyNewsLabel.isHidden = viewModel.getNumberOfRows() != 0
        emptyNewsImage.isHidden = viewModel.getNumberOfRows() != 0
        
       return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
   
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        return cell
    }
}

//MARK:- UITableViewDelegate
extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailNewsVC()
        detailVC.hidesBottomBarWhenPushed = true
        
        viewModel.news[indexPath.row].isReading = true
        tableView.reloadData()
        CoreDataManager.shared.saveNews(news: viewModel.news)
        
        detailVC.viewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK:- SourceListDataDelegate
extension NewsVC: SourceListDataDelegate {
    func updateSource(source: Source) {
        viewModel.currentSource = source
        updateNews()
    }
}




