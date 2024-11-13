//
//  FoodCollectionViewCell.swift
//  CheersMate
//
//  Created by 재훈 on 11/13/24.
//

import UIKit
import Kingfisher

// MARK: - 주류와 어울리는 안주를 보여주는 셀
public final class HorizontalListCollectionViewCell: UICollectionViewCell {
    // MARK: - 프로퍼티
    // 셀 아이디
    static let ID = "HorizontalListCollectionViewCell"
    
    // 음식 메인 이미지 뷰
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.kf.indicatorType = .activity
        return iv
    }()
    
    // 음식 이름 레이블
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.textColor
        label.numberOfLines = 2
        label.font = UIFont.pretendard(size: 15, family: .SemiBold)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - init 설정
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    // MARK: - 외부에서 프로퍼티에 접근할 때 사용할 configure 설정
    public func configure(imageURL: String?, name: String?) {
        imageView.kf.setImage(with: URL(string: imageURL ?? ""))
        nameLabel.text = name ?? "제품명이 없습니다"
    } // closed configure
    
} // closed ProductCollectionViewCell

extension HorizontalListCollectionViewCell {
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [imageView, nameLabel].forEach { self.addSubview($0) }
    } // closed setupUI
    
    // MARK: - Layout 설정
    private func setupLayout() {

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.leading.trailing.equalTo(imageView)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
    } // closed setupLayout
    
} // closed extension
