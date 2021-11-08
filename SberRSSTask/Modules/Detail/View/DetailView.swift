//
//  DetailView.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import UIKit

class DetailView: UIView {
    
   private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.Color.sberColor
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = ThemeManager.Color.titleColor

        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ThemeManager.Color.subtitleColor

        return label
    }()
    
    var detailTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        textView.textColor = ThemeManager.Color.titleColor
        textView.isEditable = false
        textView.isSelectable = false
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    // MARK: - Инициализация

    override init(frame: CGRect) {
        super.init(frame: frame)
         configureViewComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    private func configureViewComponents() {
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        overlayFirstLayer()
        overlaySecondLayer()
    }
    
    ///Наложение первого слоя UI
    func overlayFirstLayer() {
        addSubview(cardView)
        addSubview(lineView)
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(12)
            make.left.equalTo(self).offset(4)
            make.bottom.equalTo(self).offset(-12)
            make.right.equalTo(self).offset(-4)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(3)
        }
    }
    
    ///Наложение второго слоя UI
    func overlaySecondLayer() {
        
        cardView.addSubview(dateLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(detailTextView)
        
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).offset(8)
            make.left.equalTo(cardView.snp.left).offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalTo(cardView.snp.right).offset(-8)
        }
        
        
        detailTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalTo(cardView.snp.right).offset(-8)
            make.bottom.equalTo(cardView.snp.bottom)
        }
        
    }
}
