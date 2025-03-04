//
//  RecommendView.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import UIKit
import SnapKit
import Lottie

public final class RecommendHomeView: UIView {
    
    // 스크롤 뷰
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.showsVerticalScrollIndicator = true
        sv.showsHorizontalScrollIndicator = false
        sv.isDirectionalLockEnabled = true
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // 메인 컨테이너 뷰
    private let mainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    // 블러 효과 뷰
    private let shadowOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.white.cgColor // 그림자 색상
        view.layer.shadowOpacity = 1 // 불투명도
        view.layer.shadowRadius = 10 // 그림자가 퍼지는 반경
        view.layer.shadowOffset = CGSize(width: 0, height: -25) // 그림자 방향
        return view
    }()

    
    // 사용자 안내 메인 레이블
    private let mainInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "강슬기님을 위한 꼭 맞는 한 잔"
        lb.setLineSpacing(spacing: 8)
        lb.font = .gmarketSans(size: 22, family: .Medium)
        lb.textColor = .mainTextColor
        lb.numberOfLines = 0
        lb.textAlignment = .left
        return lb
    }()
    
    // 로티 애니메이션
    public let cheersAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "cheersLottie")
        animationView.loopMode = .loop // 애니메이션 무한 반복
        animationView.animationSpeed = 1.0 // 애니메이션 속도
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    // 첫 번째 서브 안내 메인 레이블
    private let firstSubInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "완벽하게 추천해 드릴게요"
        lb.font = .gmarketSans(size: 17, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 감정 안내 레이블
    private let moodInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "🙂 지금 기분에 맞게"
        lb.font = .gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 동반자 안내 레이블
    private let companionInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "👩‍❤️‍👨 누구와 함께든지"
        lb.font = .gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 선호 도수 안내 레이블
    private let volumeInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "🍺 선호하는 도수로"
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 두 번째 서브 안내 메인 레이블
    private let secondSubInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "이런 단계로 구성되어 있어요"
        lb.font = .gmarketSans(size: 17, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    private let firstStepInfolabel: UILabel = {
        let lb = UILabel()
        lb.text = "1️⃣ 총 세 가지의 질문으로"
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    private let secondStepInfolabel: UILabel = {
        let lb = UILabel()
        lb.text = "2️⃣ 지금 상황에 맞는 선택지를 모두 고르면"
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    private let thirdStepInfolabel: UILabel = {
        let lb = UILabel()
        lb.text = "3️⃣ 결과를 즉시 알려드려요"
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    private let forthStepInfolabel: UILabel = {
        let lb = UILabel()
        lb.text = "4️⃣ 마지막으로 평가까지"
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 시작하기 버튼
    public let startButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("시작하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = .gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 15
        bt.backgroundColor = .mainColor
        return bt
    }()
    
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // layoutSubviews
    public override func layoutSubviews() {
        super.layoutSubviews()
        shadowOverlayView.layer.shadowPath = UIBezierPath(rect: shadowOverlayView.bounds).cgPath
    }
    
    // UI 설정
    private func setupUI() {
        [scrollView, shadowOverlayView].forEach { self.addSubview($0) }
        [mainContainerView].forEach { scrollView.addSubview($0) }
        
        [startButton].forEach { shadowOverlayView.addSubview($0) }
        
        [mainInfoLabel, cheersAnimationView,
         firstSubInfoLabel, moodInfoLabel, companionInfoLabel, volumeInfoLabel,
         secondSubInfoLabel, firstStepInfolabel, secondStepInfolabel, thirdStepInfolabel, forthStepInfolabel].forEach { mainContainerView.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        
        // 스크롤 뷰 = 메인 컨테이너 뷰 + 섀도우 오버레이 뷰
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(shadowOverlayView.snp.top)
        }
        
        // 메인 컨테이너 뷰 = 메인 인포 레이블 + 로티 애니메이션 + 서브 인포 레이블
        mainContainerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        mainInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        cheersAnimationView.snp.makeConstraints { make in
            make.top.equalTo(mainInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(cheersAnimationView.snp.width)
        }
        
        //
        firstSubInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(cheersAnimationView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        moodInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(firstSubInfoLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        companionInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(moodInfoLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        volumeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(companionInfoLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        //
        secondSubInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(volumeInfoLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        firstStepInfolabel.snp.makeConstraints { make in
            make.top.equalTo(secondSubInfoLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        secondStepInfolabel.snp.makeConstraints { make in
            make.top.equalTo(firstStepInfolabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        thirdStepInfolabel.snp.makeConstraints { make in
            make.top.equalTo(secondStepInfolabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        forthStepInfolabel.snp.makeConstraints { make in
            make.top.equalTo(thirdStepInfolabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(35)
        }
        
        // 섀도우 효과 뷰 = 시작하기 버튼
        shadowOverlayView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(75)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    
} // closed RecommendHomeView

