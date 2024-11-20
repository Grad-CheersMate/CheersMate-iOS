//
//  RecommendEvaluateView.swift
//  CheersMate
//
//  Created by 재훈 on 11/15/24.
//

import UIKit
import Cosmos

// MARK: - 사용자가 AI 추천 주류 및 안주 서비스를 이용한 후 추천 결과를 평가하기 위한 뷰
public final class RecommendEvaluateView: UIView {
    
    // MARK: - 프로퍼티 설정
    // 그림자 효과를 적용하기 위한 뷰
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    
    // 사용자 안내 메인 레이블
    private let mainInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainNavyColor
        lb.text = "추천이 마음에 드셨나요?"
        lb.numberOfLines = 1
        lb.font = UIFont.gmarketSans(size: 23, family: .Bold)
        lb.textAlignment = .center
        return lb
    }()
    
    // 사용자 안내 서브 레이블
    private let subInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .subTextColor //UIColor.systemGray
        lb.text = "별점을 눌러 평가해 주세요!\n더 나은 추천을 위해 도움이 돼요."
        lb.setLineSpacing(spacing: 5)
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textAlignment = .center
        return lb
    }()
    
    // 별점 뷰
    public lazy var cosmosView: CosmosView = {
        let v = CosmosView()
        v.settings.starSize = 40
        v.rating = 3.0
        return v
    }()

    // 별점 안내 레이블
    public let cosmosInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "보통이에요 😐"
        lb.textColor = UIColor.systemGray
        lb.numberOfLines = 1
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textAlignment = .center
        return lb
    }()
    
    // 별점 제출 버튼
    public let submitButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("제출하기", for: .normal)
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
        setupShadow()
        setupCosmos()
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } //closed required init
    
    // MARK: - 셀에 그림자 효과를 설정
    private func setupShadow() {
        containerView.layer.shadowColor = UIColor.systemGray.cgColor
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOffset = CGSize(width: 1, height: 4) // 위치조정
        containerView.layer.shadowRadius = 10 // 반경
        containerView.layer.shadowOpacity = 1 // alpha값
    } // closed setupShadow
    
    // MARK: - 코스모스 뷰 별점에 대한 CosmosInfoLabel Configure
    public func setupCosmos() {
        cosmosView.didTouchCosmos = { [weak self] rating in
            guard let self = self else { return }
            switch rating {
            case 5.0:
                self.cosmosInfoLabel.text = "최고였어요 🥰"
            case 4.0:
                self.cosmosInfoLabel.text = "만족했어요 😊"
            case 3.0:
                self.cosmosInfoLabel.text = "보통이에요 😐"
            case 2.0:
                self.cosmosInfoLabel.text = "부족했어요 😕"
            case 1.0:
                self.cosmosInfoLabel.text = "아쉬웠어요 😞"
            default:
                break
            }
        }
    } // closed setupCosmosView
    
} // closed RecommendView

// MARK: - 초기 UI와 Layout 설정
extension RecommendEvaluateView {
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        [containerView].forEach { self.addSubview($0) }
        [mainInfoLabel, cosmosView, cosmosInfoLabel, subInfoLabel, submitButton].forEach { containerView.addSubview($0) }
        
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()  // 화면의 중앙에 배치
            make.width.equalToSuperview().multipliedBy(0.80)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        mainInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        cosmosView.snp.makeConstraints { make in
            make.top.equalTo(mainInfoLabel.snp.bottom).offset(65)
            make.centerX.equalToSuperview()
        }
        
        cosmosInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(cosmosView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        subInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(cosmosInfoLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    } // closed setupLayout
    
} // closed extension

