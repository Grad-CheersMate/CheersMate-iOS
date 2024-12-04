//
//  EmailSearchSuccessView.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit
import SnapKit

public final class AccountFinderSuccessView: UIView {
    
    // 메인 타이틀 레이블
    private let mainTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = .gmarketSans(size: 27, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        lb.numberOfLines = 2
        return lb
    }()
    
    // 서브 타이틀 레이블
    private let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = .gmarketSans(size: 17, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .left
        lb.numberOfLines = 2
        return lb
    }()
    
    // 이메일 주소 또는 비밀번호 결과 레이블
    private let emailOrPasswordResultLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 또는 비밀번호 결과 창
    public var emailOrPasswordResultTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = ""
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainTextColor
        tf.layer.borderColor = UIColor.textFieldLayerColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.isUserInteractionEnabled = true // 상호작용 허용
        tf.isEnabled = false // 입력 금지
        tf.leftPadding() // 왼쪽 패딩 추가
        return tf
    }()
    
    // 확인 버튼
    public var completeButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("확인", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = .gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 15
        bt.backgroundColor = .buttonAbleColor
        return bt
    }()
    
    // init
    public init(type: AccountFindType, resultInfo: String) {
        super.init(frame: .zero)
        setupTitlesAndResultLabelAndTextField(type: type, resultInfo: resultInfo)
        setupUI()
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 타이틀, 결과 레이블, 텍스트 필드 설정
    private func setupTitlesAndResultLabelAndTextField(type: AccountFindType, resultInfo: String) {
        switch type {
        case .findEmail:
            mainTitleLabel.text = "이메일 주소 찾기에\n성공했어요"
            subTitleLabel.text = "아래의 이메일 주소를 확인해 주세요"
            emailOrPasswordResultLabel.text = "이메일 주소"
        case .findPassword:
            mainTitleLabel.text = "비밀번호 찾기에\n성공했어요"
            subTitleLabel.text = "우선 임시 비밀번호를 전달해 드릴게요"
            emailOrPasswordResultLabel.text = "임시 비밀번호"
        }
        mainTitleLabel.setLineSpacing(spacing: 3)
        emailOrPasswordResultTextField.text = resultInfo
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [mainTitleLabel, subTitleLabel, emailOrPasswordResultLabel, emailOrPasswordResultTextField, completeButton]
            .forEach { self.addSubview($0) }
        
    }
    
    // Layout 설정
    private func setupLayout() {
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        emailOrPasswordResultLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        emailOrPasswordResultTextField.snp.makeConstraints { make in
            make.top.equalTo(emailOrPasswordResultLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(emailOrPasswordResultTextField.snp.bottom).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
} // closed AccountFinderSuccessView
