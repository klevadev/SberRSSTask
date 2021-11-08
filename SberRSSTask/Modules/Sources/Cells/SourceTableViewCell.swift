//
//  SourceTableViewCell.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    static let reuseId = "SoruceTableViewCell"
    
    weak var viewModel: SourceTableViewCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            urlLabel.text = viewModel.url
            self.accessoryType = viewModel.isCurrent ? .checkmark : .none
        }
    }

    // MARK: - Создание объектов кастомной ячейки

   private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = ThemeManager.Color.titleColor

        return label
    }()

    let urlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ThemeManager.Color.subtitleColor

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        self.tintColor = ThemeManager.Color.sberColor

        overlayFirstLayer()
        overlaySecondLayer()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Наложение первого слоя UI
    func overlayFirstLayer() {
        addSubview(cardView)
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(12)
            make.left.equalTo(self).offset(16)
            make.bottom.equalTo(self).offset(-12)
            make.right.equalTo(self).offset(-12)
        }
        
        let bottomConstraint = cardView.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint.priority = UILayoutPriority(999)
        bottomConstraint.isActive = true
    }
    
    ///Наложение второго слоя UI
    func overlaySecondLayer() {

        cardView.addSubview(titleLabel)
        cardView.addSubview(urlLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).offset(16)
            make.left.equalTo(cardView.snp.left).offset(12)
            make.right.equalTo(cardView.snp.right).offset(-10)
        }

        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(cardView.snp.bottom).offset(-12)
            make.right.equalTo(cardView.snp.right).offset(-10)
        }
    }

}

