//
//  ProductListCollectionViewCell.swift
//  CheersMate
//
//  Created by 재훈 on 11/19/24.
//


import UIKit
import Kingfisher

public final class ProductCollectionViewCell: UICollectionViewCell {
    // 셀 아이디
    static let ID = "ProductCollectionViewCell"

    // 주류 이미지 뷰
    private let liquorImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.kf.indicatorType = .activity
        return iv
    }()
    // 주류 정보 레이블 1
    public let liquorInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.textColor = .subTextColor
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
//    private let heartButton: UIButton = {
//        let bt = UIButton(type: .custom)
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
//        let normalImage = UIImage(systemName: "heart", withConfiguration: imageConfig)
//        let selectedImage = UIImage(systemName: "heart.fill", withConfiguration: imageConfig)
//        bt.setImage(normalImage, for: .normal)
//        bt.setImage(selectedImage, for: .selected)
//        bt.tintColor = .red
//        bt.adjustsImageWhenHighlighted = false
//        bt.clipsToBounds = true
//        return bt
//    }()
    
    // 셀 재사용
    public override func prepareForReuse() {
        super.prepareForReuse()
        liquorImageView.image = nil
        liquorInfoLabel.text = ""
    }
    // init 설정
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
        self.layer.cornerRadius = 15
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 15
        self.contentView.clipsToBounds = true
        
        [liquorImageView, liquorInfoLabel].forEach { self.contentView.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        liquorImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }
        
        liquorInfoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        liquorInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(liquorImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
    }
    
    // configure
    public func configure(liquor: Liquor) {
        liquorImageView.kf.setImage(with: URL(string: liquor.imageUrl ?? ""))
        
        liquorInfoLabel.text = liquor.name
        liquorInfoLabel.setLineSpacing(spacing: 5)
        liquorInfoLabel.textAlignment = .center
    }
    
    public func updateLiquorImage(_ height: Int) {
        liquorImageView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    
} // closed ProductCollectionViewCell
