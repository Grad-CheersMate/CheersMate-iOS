//
//  ProductCollectionViewCell.swift
//  CheersMate
//
//  Created by 재훈 on 11/13/24.
//

import UIKit
import Kingfisher

public final class ProductCollectionViewCell: UICollectionViewCell {
    // 셀 아이디
    static let ID = "ProductCollectionViewCell"
    
    // 메인 이미지 뷰
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.kf.indicatorType = .activity
        return iv
    }()
    
    // 이름 레이블
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.textColor
        label.numberOfLines = 2
        label.font = UIFont.pretendard(size: 18, family: .SemiBold)
        label.textAlignment = .left
        return label
    }()
    
    // 타입 레이블
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.textColor
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // 도수 레이블
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.textColor
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // 이름 레이블, 주류 타입 레이블, 도수 레이블을 묶는 스택 뷰
    private lazy var labelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, typeLabel, volumeLabel])
        sv.axis = .vertical
        sv.distribution = .equalSpacing // 동일한 간격을 주고, 여백이 있을 경우 Priority 설정에 따라 사이즈 조절
        sv.alignment = .fill
        sv.spacing = 10
        return sv
    }()
    
    private let heartButton: UIButton = {
        let bt = UIButton(type: .custom)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let normalImage = UIImage(systemName: "heart", withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: "heart.fill", withConfiguration: imageConfig)
        bt.setImage(normalImage, for: .normal)
        bt.setImage(selectedImage, for: .selected)
        bt.tintColor = .mainColor
        bt.adjustsImageWhenHighlighted = false
        bt.clipsToBounds = true
        return bt
    }()
    
    // MARK: - 셀 재사용
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
        typeLabel.text = ""
        volumeLabel.text = ""
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
    
    public func configure(imageURL: String?, name: String?, type: String?, volume: Double?) {
        imageView.kf.setImage(with: URL(string: imageURL ?? ""))
        nameLabel.text = name ?? "제품명이 없습니다"
        typeLabel.text = (type != nil) ? "주종: \(type!)" : "주종 정보가 없습니다"
        volumeLabel.text = (volume != nil) ? "도수: \(volume!)%" : "도수 정보가 없습니다"
    } // closed configure
    
} // closed ProductCollectionViewCell

extension ProductCollectionViewCell {
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [imageView, labelStackView, heartButton].forEach { self.addSubview($0) }
    } // closed setupUI
    
    // Layout 설정
    private func setupLayout() {

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(25)
            make.trailing.lessThanOrEqualTo(heartButton.snp.leading).offset(-50)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        typeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        volumeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(labelStackView)
            make.trailing.equalToSuperview().inset(25)
            make.width.equalTo(heartButton.snp.height)
        }
        
    } // closed setupLayout
    
} // closed extension
