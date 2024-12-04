//
//  SearchingEmailView.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

// MARK: - 사용자가 본인 계정의 이메일 주소 또는 비밀번호를 찾기 위한 화면.

import UIKit

final public class AccountFinderView: UIView {
    
    // 타이틀 레이블
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = .gmarketSans(size: 17, family: .Medium)
        lb.numberOfLines = 2
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 또는 닉네임 레이블
    private let nicknameOrEmailLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 또는 닉네임 입력 창
    public let nicknameOrEmailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = ""
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainTextColor
        tf.layer.borderColor = UIColor.textFieldLayerColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        tf.leftPadding()
        return tf
    }()
    
    // 이메일 주소 또는 닉네임 정규식 검증 레이블
    public let nicknameOrEmailFeedbackLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = .gmarketSans(size: 12, family: .Medium)
        lb.textColor = .systemRed
        lb.textAlignment = .left
        lb.isHidden = true
        return lb
    }()
    
    // 휴대폰 번호 레이블
    private let tellLabel: UILabel = {
        let lb = UILabel()
        lb.text = "휴대폰 번호"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 휴대폰 번호 입력 창
    public let tellTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = "01012345678"
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainTextColor
        tf.layer.borderColor = UIColor.textFieldLayerColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.keyboardType = .numberPad
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        tf.leftPadding()
        return tf
    }()
    
    // 휴대폰 번호 정규식 검증 레이블
    public let tellFeedbackLabel: UILabel = {
        let lb = UILabel()
        lb.text = "휴대폰 번호를 바르게 입력해 주세요."
        lb.font = .gmarketSans(size: 12, family: .Medium)
        lb.textColor = .systemRed
        lb.textAlignment = .left
        lb.isHidden = true
        return lb
    }()
    
    // 계정 찾기 버튼
    public let findButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("계정 찾기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 16, family: .Medium)
        bt.layer.cornerRadius = 15
        bt.backgroundColor = .buttonDisableColor
        return bt
    }()
    
    // init
    init (type: AccountFindType) {
        super.init(frame: .zero)
        setupTitleLabel(type: type)
        setupUserInfo(type: type)
        setupFeedBackInfo(type: type)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setuptitleLabel
    private func setupTitleLabel(type: AccountFindType) {
        titleLabel.text = type.description
        titleLabel.setLineSpacing(spacing: 5)
    }
    
    // setupUserInfo
    private func setupUserInfo(type: AccountFindType) {
        nicknameOrEmailLabel.text = type.userInfo.label
        nicknameOrEmailTextField.placeholder = type.userInfo.placeholder
    }
    
    // setupFeedBackInfo
    private func setupFeedBackInfo(type: AccountFindType) {
        switch type {
        case .findEmail: // 이메일 찾기
            nicknameOrEmailFeedbackLabel.text = "2 ~ 16자의 한글, 영문, 숫자 조합으로 작성해 주세요."
        case .findPassword: // 비밀번호 찾기
            nicknameOrEmailFeedbackLabel.text = "잘못된 이메일 형식입니다."
        }
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [titleLabel, nicknameOrEmailLabel, nicknameOrEmailTextField, nicknameOrEmailFeedbackLabel, tellLabel, tellTextField, tellFeedbackLabel, findButton].forEach { self.addSubview($0) }
        
    }

    // Layout 설정
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        nicknameOrEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        nicknameOrEmailTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameOrEmailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        nicknameOrEmailFeedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameOrEmailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameOrEmailTextField.snp.bottom).offset(45)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tellTextField.snp.makeConstraints { make in
            make.top.equalTo(tellLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        tellFeedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(tellTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        findButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(tellTextField.snp.bottom).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(115)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
    }
    
} // closed AccountFinderView
