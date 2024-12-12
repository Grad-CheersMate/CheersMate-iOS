//
//  HeaderView.swift
//  CheersMate
//
//  Created by 재훈 on 11/14/24.
//

import UIKit

// MARK: - 컬렉션 뷰에서 사용되는 헤더 뷰

public final class TitleHeaderView: UICollectionReusableView {
    
    // reusable ID
    static let ID = "TitleHeaderView"
    
    // 헤더 타이틀 레이블
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .gmarketSans(size: 19, family: .Medium)
        label.textColor = .mainTextColor
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 헤더 버튼
    private let subButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("더보기", for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 14, family: .Medium)
        bt.setTitleColor(.subTextColor, for: .normal)
        bt.isHidden = false
        return bt
    }()
    
    // prepareForReuse
    public override func prepareForReuse() {
        super.prepareForReuse()
        mainTitleLabel.text = ""
    }
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 외부에서 프로퍼티를 변경하기 위한 configure 설정
    public func configure(title: String, isSubButtonHidden: Bool) {
        mainTitleLabel.text = title
        subButton.isHidden = isSubButtonHidden
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        [mainTitleLabel, subButton].forEach { self.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        mainTitleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        subButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(mainTitleLabel.snp.trailing).offset(10)
            make.top.bottom.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
    
} // closed HeaderView
