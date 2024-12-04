//
//  PopUpView.swift
//  CheersMate
//
//  Created by 재훈 on 12/2/24.
//

import UIKit
import SnapKit

public final class PopUpView: UIView {
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [mainTitleLabel, subTitleLabel, completeButton])
        sv.axis = .vertical
        sv.spacing = 30
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
    // 메인 제목 레이블
    private let mainTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = .gmarketSans(size: 27, family: .Medium)
        lb.textColor = .mainTextColor
        lb.numberOfLines = 0
        lb.textAlignment = .left
        return lb
    }()
    
    // 서브 제목 레이블
    private let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = .gmarketSans(size: 16, family: .Medium)
        lb.textColor = .subTextColor
        lb.numberOfLines = 0
        lb.textAlignment = .left
        return lb
    }()
    
    // 확인 버튼
    public let completeButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("확인", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = .gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 15
        bt.backgroundColor = .buttonAbleColor
        return bt
    }()
    
    // init
    public init(title: String, subTitle: String) {
        super.init(frame: .zero)
        setupLabel(title: title, subTitle: subTitle)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setupLabel - 팝업 화면에 표시할 메인과 서브 타이틀 메시지를 설정
    private func setupLabel(title: String, subTitle: String) {
        mainTitleLabel.text = title
        mainTitleLabel.setLineSpacing(spacing: 7)
        subTitleLabel.text = subTitle
        subTitleLabel.setLineSpacing(spacing: 7)
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .popUpBackgroundColor.withAlphaComponent(0.8)
        [containerView].forEach { self.addSubview($0) }
        [stackView].forEach { containerView.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
        
        completeButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
    }
    
} // closed PopUpView
