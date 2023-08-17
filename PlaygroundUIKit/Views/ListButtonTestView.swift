//
//  ListButtonTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/08/03.
//

import Foundation
import UIKit

protocol ListButtonTestViewDelegate {
    func listButtonTapAction()
}

class ListButtonTestView: UIView {
    
    var listButtonTestViewDelegate: ListButtonTestViewDelegate?
    
    var listButton: ListButton?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLoad
    func viewLoad() {
        listButton = ListButton(title: "あいうえお",
                                borderColor: .lightGray,
                                target: self,
                                action: #selector(listButtonTapAction))
        listButton?.setAutoLayout(paddingLeft: 12, paddingRight: 12)
        
        self.addSubview(listButton!)
        
        listButton?.translatesAutoresizingMaskIntoConstraints = false
        listButton?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        listButton?.heightAnchor.constraint(equalToConstant: 44).isActive = true
        listButton?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        listButton?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    @objc func listButtonTapAction(_ sender: UIButton) {
        listButtonTestViewDelegate?.listButtonTapAction()
    }
    
}


class ListButton: UIControl {
    
    // MARK: - Member
    let titleLabel: UILabel = UILabel()
    let imageView: UIImageView = UIImageView()
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    
    
    // MARK: - ハイライト用のUIの変数と、ハイライトに必要なオーバーライド
    var highlightView: UIView = UIView()

    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.05, animations: {
                    self.highlightView.alpha = 0.5
                })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.highlightView.alpha = 0.0
                })
            }
        }
    }
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String,
                     titleColor: UIColor = .black,
                     borderColor: UIColor = .lightGray,
                     borderWidth: CGFloat = 1.0,
                     target: Any? = nil,
                     action: Selector? = nil) {
        self.init()
        
        // ボタンのタイトルを設定
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.sizeToFit()
        self.addSubview(titleLabel)
        
        // 「＞」の画像を設定
        imageView.image = UIImage(named: "arrow-icon")
        self.addSubview(imageView)
        
        // ボーダーの色を設定
        self.borderColor = borderColor
        
        // ボーダーの太さを設定
        self.borderWidth = borderWidth
        
        // アクションの設定
        if let _action: Selector = action {
            let tapGesture = UITapGestureRecognizer(target: target, action: _action)
            self.addGestureRecognizer(tapGesture)
        }
        
        // ハイライト用のviewを設定
        highlightView.backgroundColor = .lightGray
        highlightView.alpha = 0.0
        self.addSubview(highlightView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - AutoLayout
    func setAutoLayout(paddingLeft: CGFloat = 0.0, paddingRight: CGFloat = 0.0) {
        // タイトルの設定
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: paddingLeft).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // 画像の設定
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -paddingRight).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // 上下のボーダーの設定
        self.drawTopBorder(color: borderColor!, borderWidth: borderWidth!)
        self.drawBottomBorder(color: borderColor!, borderWidth: borderWidth!)
        // ハイライト用のViewの設定
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        highlightView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        highlightView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        highlightView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        highlightView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}
