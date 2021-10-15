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

        cardView.setPosition(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 12,
                             paddingLeft: 4,
                             paddingBottom: 12,
                             paddingRight: 4)
        
        lineView.setPosition(top: cardView.topAnchor,
                             left: cardView.leftAnchor,
                             bottom: nil,
                             right: cardView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: 3)
    }
    
    ///Наложение второго слоя UI
    func overlaySecondLayer() {
        
        cardView.addSubview(dateLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(detailTextView)
        
        dateLabel.setPosition(top: cardView.topAnchor,
                              left: cardView.leftAnchor,
                              bottom: nil,
                              right: nil,
                              paddingTop: 8,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 0)
        
        
        titleLabel.setPosition (top: dateLabel.bottomAnchor,
                                left: dateLabel.leftAnchor,
                                bottom: nil,
                                right: cardView.rightAnchor,
                                paddingTop: 4,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 8)
        
        detailTextView.setPosition(top: titleLabel.bottomAnchor,
                                   left: dateLabel.leftAnchor,
                                   bottom: cardView.bottomAnchor,
                                   right: cardView.rightAnchor,
                                   paddingTop: 4,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 8)
        
    }
}
