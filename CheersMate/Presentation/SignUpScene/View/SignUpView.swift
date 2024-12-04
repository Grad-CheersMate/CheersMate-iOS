//
//  SignUpView.swift
//  CheersMate
//
//  Created by 재훈 on 10/23/24.
//

// MARK: - 사용자가 자신만의 계정을 생성하기 위한 화면.

import UIKit

final public class SignUpView: UIView {
    
    // 네비게이션 바의 왼쪽 아이템 설정
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: rightBarCrossButton)
    
    // 네비게이션 오른쪽 바 버튼 아이템 - x 이미지
    public let rightBarCrossButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "cross"), for: .normal)
        bt.tintColor = .mainTextColor
        return bt
    }()
    
    // 스크롤 뷰
    public let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.isDirectionalLockEnabled = true
        sv.alwaysBounceVertical = true
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    // 메인 컨테이너 뷰
    private let mainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    // 타이틀 레이블
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "당신만을 위한 주류 추천 서비스\nCheersMate와 함께하세요!"
        lb.setLineSpacing(spacing: 5)
        lb.font = .gmarketSans(size: 16, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        lb.numberOfLines = 2
        return lb
    }()
    
    // 이메일 주소 레이블
    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "이메일 주소"
        lb.font = .gmarketSans(size: 14, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 입력 창
    public let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = "이메일 주소를 입력해 주세요"
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
    
    // 이메일 주소 정규식 검증 레이블
    public let emailFeedbackLabel: UILabel = {
        let lb = UILabel()
        lb.text = "잘못된 이메일 형식입니다."
        lb.font = .gmarketSans(size: 12, family: .Medium)
        lb.textColor = .systemRed
        lb.textAlignment = .left
        lb.isHidden = true
        return lb
    }()
    
    // 비밀번호 레이블
    private let passwordLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainTextColor
        lb.text = "비밀번호"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 비밀번호 가리기 버튼
    private let secureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        return button
    }()
    
    // 비밀번호 입력 창
    public let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = "비밀번호를 입력해 주세요"
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainTextColor
        tf.layer.borderColor = UIColor.textFieldLayerColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.keyboardType = .default
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        tf.isSecureTextEntry = true
        tf.leftPadding()
        return tf
    }()
    
    // 비밀번호 정규식 검증 레이블
    public let passwordFeedbackLabel: UILabel = {
        let lb = UILabel()
        lb.text = "최소 8자의 대소문자와 숫자만 입력해 주세요."
        lb.font = .gmarketSans(size: 12, family: .Medium)
        lb.textColor = .systemRed
        lb.textAlignment = .left
        lb.isHidden = true
        return lb
    }()
    
    // 닉네임 주소 레이블
    private let nickNameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainTextColor
        lb.text = "닉네임"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 닉네임 입력 창
    public let nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = "닉네임을 입력해 주세요"
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainTextColor
        tf.layer.borderColor = UIColor.textFieldLayerColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.keyboardType = .default
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        tf.leftPadding()
        return tf
    }()
    
    // 닉네임 정규식 검증 레이블
    public let nicknameFeedbackLabel: UILabel = {
        let lb = UILabel()
        lb.text = "2 ~ 16자의 한글, 영문, 숫자 조합으로 작성해 주세요."
        lb.font = .gmarketSans(size: 12, family: .Medium)
        lb.textColor = .systemRed
        lb.textAlignment = .left
        lb.isHidden = true
        return lb
    }()

    // 휴대폰 번호 레이블
    private let tellLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainTextColor
        lb.text = "휴대폰 번호"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
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
    
    // 가입하기 버튼
    public let signUpButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("가입하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = .gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 15
        bt.backgroundColor = .buttonDisableColor
        return bt
    }()
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [scrollView, signUpButton].forEach { self.addSubview($0) }
        [mainContainerView].forEach { scrollView.addSubview($0) }
        [titleLabel, emailLabel, emailTextField, emailFeedbackLabel, passwordLabel, passwordTextField, passwordFeedbackLabel, nickNameLabel, nickNameTextField, nicknameFeedbackLabel, tellLabel, tellTextField, tellFeedbackLabel].forEach { mainContainerView.addSubview($0) }
    
    }

    // Layout 설정
    private func setupLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(signUpButton.snp.top).offset(-10)
        }
        
        mainContainerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        emailFeedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(45)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        passwordFeedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(45)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        nicknameFeedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(45)
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
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
} // closed SignUpView
