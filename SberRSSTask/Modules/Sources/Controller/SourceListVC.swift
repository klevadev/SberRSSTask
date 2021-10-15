//
//  SourceListVC.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//
import UIKit

protocol SourceListDataDelegate: AnyObject {
    func updateSource(source: Source)
}

class SourceListVC: UIViewController {
    
    // MARK: - Свойства
    private var viewModel: SourceListViewModelProtocol!
    weak var delegate: SourceListDataDelegate?
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let emptySourceLabel: UILabel = {
        let label = UILabel()
        label.text = "Кажется у Вас нет еще источников новостей\n Добавьте их!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptySourceImage: UIImageView = {
        let image = #imageLiteral(resourceName: "not-found")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addSourceAlert: UIAlertController = {
        
        let alert = UIAlertController(title: "Добавьте RSS-источник", message: "Введите название источника и его адрес", preferredStyle:UIAlertController.Style.alert)
        
        alert.addTextField {
            $0.placeholder = "Название"
            $0.delegate = self
            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }
        
        alert.addTextField {
            $0.placeholder = "Адрес"
            $0.delegate = self
            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: {
                                    (action : UIAlertAction) -> Void in })
        
        alert.addAction(cancel)
        
        let save = UIAlertAction(title: "Сохранить", style: UIAlertAction.Style.default, handler: { [unowned self] saveAction -> Void in
            guard let titleTextField = alert.textFields?[0],
                  let urlTextField = alert.textFields?[1] else { return }
            
            guard let title = titleTextField.text, let url = urlTextField.text else { return }
                        
            self.viewModel.createNewSource(title: title, url: url, isCurrent: true)
            guard let currentSource = self.viewModel.currentSource else { return }
            
            self.tableView.reloadData()
            self.delegate?.updateSource(source: currentSource)
            self.viewModel.saveSourcesInUserDefaults()
           
            titleTextField.text = ""
            urlTextField.text = ""
            saveAction.isEnabled = false
        })
        
        save.isEnabled = false
        alert.addAction(save)
    
        return alert
    }()
    
    // MARK: - Функции
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ThemeManager.Color.backgroundColor
        setupTableView()
        setupAddSourceBarButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SourceListViewModel()
        viewModel.loadSourcesFromUserDefaults()
    }
    
    @objc func addSourceClicked(btn: UIBarButtonItem){
        self.present(addSourceAlert, animated: true, completion: nil)
    }
    
    // Установка UITableView
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.addSubview(emptySourceLabel)
        tableView.addSubview(emptySourceImage)
        setupConstraints()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(SourceTableViewCell.self, forCellReuseIdentifier: SourceTableViewCell.reuseId)
        
        setupConstraints()
    }
    
    // Установка Constraint для UITableView
    private func setupConstraints() {
        tableView.fillToSuperView(view: view)
        
        emptySourceLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptySourceLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 50).isActive = true

        emptySourceImage.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptySourceImage.topAnchor.constraint(equalTo: emptySourceLabel.bottomAnchor, constant: 25).isActive = true
    }
    
    private func setupAddSourceBarButton() {
        let addSourceBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSourceClicked(btn:)))
        self.navigationItem.rightBarButtonItem  = addSourceBarButton
        self.navigationItem.rightBarButtonItem?.tintColor = ThemeManager.Color.sberColor
    }
}

//MARK:- UITableViewDataSource
extension SourceListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptySourceLabel.isHidden = viewModel.getNumberOfRows() != 0
        emptySourceImage.isHidden = viewModel.getNumberOfRows() != 0
        
       return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.viewModel.sources.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.viewModel.saveSourcesInUserDefaults()
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SourceTableViewCell.reuseId, for: indexPath) as? SourceTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        return cell
    }
}
//MARK:- UITableViewDelegate
extension SourceListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.resetCurrentSource()
        
        viewModel.currentSource = viewModel.sources[indexPath.row]
        
        viewModel.sources[indexPath.row].isCurrent = true
        
        tableView.reloadData()
        
        guard let newSource = viewModel.currentSource else { return }
        self.delegate?.updateSource(source: newSource)
    }
}

//MARK:- UITextFieldDelegate
extension SourceListVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


