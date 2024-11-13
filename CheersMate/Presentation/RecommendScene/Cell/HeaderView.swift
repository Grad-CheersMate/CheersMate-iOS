//
//  HeaderView.swift
//  CheersMate
//
//  Created by 재훈 on 11/14/24.
//

import UIKit

// MARK: - 컬렉션 뷰에서 사용되는 헤더 뷰
public final class HeaderView: UICollectionReusableView {
    // MARK: - 프로퍼티
    // 아이디
    static let ID = "HeaderView"
    
    // 타이틀 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .gmarketSans(size: 20, family: .Bold)
        label.textColor = .textColor
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    // MARK: - 외부에서 프로퍼티를 변경하기 위한 configure 설정
    public func configure(title: String) {
        titleLabel.text = title
    } // closed configure
    
} // closed HeaderView

extension HeaderView {
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)
    } // closed setupUI
    
    // Layout 설정
    private func setupLayout() {

        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
    } // closed setupLayout
    
} // closed extension
