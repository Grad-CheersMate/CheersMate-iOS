//
//  FoodCollectionViewCell.swift
//  CheersMate
//
//  Created by 재훈 on 11/13/24.
//

// MARK: - 주류와 어울리는 안주를 보여주는 셀

import UIKit
import Kingfisher

public final class RecommendFoodCollectionViewCell: UICollectionViewCell {
    // 아이디
    static let ID = "RecommendFoodCollectionViewCell"
    
    // 메인 이미지 뷰
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.kf.indicatorType = .activity
        return iv
    }()
    
    // 이름 레이블
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.textColor = .mainTextColor
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    // 셀 재사용
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
    } // closed prepareForReuse
    
    // init 설정
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 외부에서 프로퍼티에 접근할 때 사용할 configure 설정
    public func configure(food: Food) {
        imageView.kf.setImage(with: URL(string: food.imageUrl))
        nameLabel.text = food.name
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 15
        self.contentView.clipsToBounds = true
        [imageView, nameLabel].forEach { self.contentView.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        // 이미지
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
        // 이름
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
} // closed RecommendFoodCollectionViewCell
