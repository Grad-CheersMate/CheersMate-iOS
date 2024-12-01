//
//  SearchingEmailView.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

// MARK: - 사용자의 이메일 또는 비밀번호를 찾기 위한 뷰

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
    
    // 사용자 정보 레이블 - 이메일 또는 닉네임
    private let userInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 사용자 정보 입력 창
    public let userInfoTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = ""
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainNavyColor
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
        tf.textColor = .mainNavyColor
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
    
    // 이메일 또는 비밀번호 찾기 버튼
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
        userInfoLabel.text = type.userInfo.label
        userInfoTextField.placeholder = type.userInfo.placeholder
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [titleLabel, userInfoLabel, userInfoTextField, tellLabel, tellTextField, findButton].forEach { self.addSubview($0) }
        
    }

    // Layout 설정
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        userInfoTextField.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tellTextField.snp.makeConstraints { make in
            make.top.equalTo(tellLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
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
