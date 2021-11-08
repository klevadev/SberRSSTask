//
//  NewsTableViewCell.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    static let reuseId = "NewsTableViewCell"
    
    weak var viewModel: NewsTableViewCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            dateLabel.text = viewModel.date
            isSelectedView.isHidden = viewModel.isReading ? false : true
        }
    }
    
    // MARK: - Создание объектов кастомной ячейки
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let isSelectedView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.Color.sberColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        overlayFirstLayer()
        overlaySecondLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    ///Наложение первого слоя UI
    func overlayFirstLayer() {
        addSubview(cardView)
        addSubview(isSelectedView)
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(12)
            make.left.equalTo(self).offset(16)
            make.bottom.equalTo(self).offset(-12)
            make.right.equalTo(self).offset(-12)
        }
        
        isSelectedView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top)
            make.left.equalTo(cardView.snp.left)
            make.bottom.equalTo(cardView.snp.bottom)
            make.width.equalTo(4)
        }
    }
    
    ///Наложение второго слоя UI
    func overlaySecondLayer() {
        
        cardView.addSubview(titleLabel)
        cardView.addSubview(dateLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).offset(16)
            make.left.equalTo(cardView.snp.left).offset(12)
            make.right.equalTo(cardView.snp.right).offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel.snp.left).offset(0)
            make.bottom.equalTo(cardView.snp.bottom).offset(-12)
        }
    }
        
    deinit {
        print("Deinit Cell")
    }
}
