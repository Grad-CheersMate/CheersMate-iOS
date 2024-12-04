//
//  CategoryTableViewCell.swift
//  CheersMate
//
//  Created by 재훈 on 11/17/24.
//

import UIKit

// MARK: - 카테고리 셀 (메인 이미지 + 설명 레이블 + 서브 이미지)
public final class CategoryTableViewCell: UITableViewCell {
    
    static let ID = "CategoryTableViewCell"
    
    // 메인 이미지 뷰
    private let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    // 설명 레이블
    private let descLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainTextColor
        lb.text = ""
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        lb.numberOfLines = 0
        return lb
    }()
    
    // 서브 이미지 뷰
    private let subImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .buttonColor
        iv.clipsToBounds = true
        return iv
    }()
    
    private var productType: ProductType = .beer
    
    // 셀 재사용
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 25, left: 30, bottom: 25, right: 25))
    }
    
    // init 설정
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        [mainImageView, descLabel, subImageView].forEach { self.contentView.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        mainImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(mainImageView.snp.height)
        }
        descLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(50)
            make.trailing.equalTo(subImageView.snp.leading).offset(-30)
            make.centerY.equalToSuperview()
        }
        subImageView.snp.makeConstraints { make in
            make.leading.equalTo(descLabel.snp.trailing)
            make.top.bottom.equalTo(descLabel)
            make.trailing.equalToSuperview()
            //make.width.equalTo(30)
        }
    }
    
    // configure 설정
    public func configure(imageText: String, descText: String, productType: ProductType) {
        self.mainImageView.image = UIImage(named: imageText)
        self.descLabel.text = descText
        self.productType = productType
    }
    
    
} // closed CategoryTableViewCell
