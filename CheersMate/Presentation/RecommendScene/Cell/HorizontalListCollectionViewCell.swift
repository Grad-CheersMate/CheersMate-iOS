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
    
    // 이미지와 레이블을 포함하는 스택뷰
    private lazy var stackview: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageView, nameLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
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
        label.textColor = .mainTextColor
        label.numberOfLines = 2
        label.font = UIFont.pretendard(size: 15, family: .SemiBold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - 셀 재사용
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
    } // closed prepareForReuse
    
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
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [stackview].forEach { self.addSubview($0) }
    } // closed setupUI
    
    // MARK: - Layout 설정
    private func setupLayout() {
        
        stackview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
    } // closed setupLayout
    
} // closed ProductCollectionViewCell
