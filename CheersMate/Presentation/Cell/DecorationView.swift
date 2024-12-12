//
//  DecorationView.swift
//  CheersMate
//
//  Created by 재훈 on 12/12/24.
//

// MARK: - 컬렉션 뷰 내부 섹션의 배경을 위한 데코레이션 뷰

import UIKit

public final class DecorationView: UICollectionReusableView {
    
    // reusable ID
    static let ID = "DecorationView"
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
    }
    
} // closed DecorationView
