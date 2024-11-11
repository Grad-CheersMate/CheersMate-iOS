//
//  RecommendView.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import UIKit
import SnapKit
import Lottie

final public class RecommendHomeView: UIView {
    
    // MARK: - 프로퍼티 설정
    // 사용자 안내 메인 레이블
    private let mainInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "나만을 위한 주류 및 안주 추천!"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 23, family: .Bold)
        lb.textAlignment = .left
        return lb
    }()
    
    // 사용자 안내 서브 레이블
    private let subInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.systemGray
        lb.text = "현재 나의 상태에 꼭 맞는 주류와 안주를\nAI가 추천해 드릴게요."
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 건배 애니메이션
    public let cheersAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "cheersLottie")
        animationView.loopMode = .loop // 애니메이션 무한 반복
        animationView.animationSpeed = 1.0 // 애니메이션 속도
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    // 시작하기 버튼
    public let startButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("맞춤 추천 시작하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 12
        bt.backgroundColor = .mainColor
        return bt
    }()

    // MARK: - 오버라이드 함수 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } //closed required init
    
} // closed RecommendView

// MARK: - 초기 UI와 Layout 설정
extension RecommendHomeView {
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [mainInfoLabel, subInfoLabel, cheersAnimationView, startButton].forEach {
            self.addSubview($0) }
        
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        
        mainInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        subInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        cheersAnimationView.snp.makeConstraints { make in
            make.top.equalTo(subInfoLabel.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(cheersAnimationView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    } // closed setupLayout
    
} // closed extension
