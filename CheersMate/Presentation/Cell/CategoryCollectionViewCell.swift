//
//  CategoryCollectionViewCell.swift
//  CheersMate
//
//  Created by 재훈 on 12/8/24.
//

import UIKit
import SnapKit

public final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let ID = "CategoryCollectionViewCell"
    
    private var productType: ProductType = .beer
    
    private let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = .beer
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "맥주"
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()

    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        self.contentView.backgroundColor = .clear
        
        [mainImageView, titleLabel].forEach { self.contentView.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    // configure
    public func configure(imageName: String, title: String, productType: ProductType) {
        self.mainImageView.image = UIImage(named: imageName)
        self.titleLabel.text = title
        self.productType = productType
    }
    
    
} // closed CategoryCollectionViewCell
