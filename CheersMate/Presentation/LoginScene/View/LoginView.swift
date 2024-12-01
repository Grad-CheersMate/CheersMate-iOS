//
//  LoginView.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

// MARK: - 사용자가 자신의 계정으로 로그인을 하기 위한 화면.

import UIKit
import SnapKit

final public class LoginView: UIView {
    
    // 타이틀 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.font = .gmarketSans(size: 30, family: .Medium)
        label.textColor = .mainTextColor
        label.textAlignment = .left
        return label
    }()
    
    // 이메일 주소 레이블
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainTextColor
        label.text = "이메일 주소"
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    
    // 이메일 주소 입력 창
    public let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = "이메일 주소를 입력해주세요"
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
    
    // 비밀번호 레이블
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainTextColor
        label.text = "비밀번호"
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    
    // 비밀번호를 표시 여부 버튼
    private let secureButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "eye"), for: .normal)
        bt.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        bt.isHighlighted = false
        return bt
    }()
    
    // 비밀번호 입력 창
    public lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.placeholder = "비밀번호를 입력해주세요"
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainNavyColor
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
    
    // 이메일 찾기 버튼, 비밀번호 찾기 버튼, 계정 찾기 버튼을 묶는 스택 뷰
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailSearchButton, seperateView1, passwordSearchButton, seperateView2, signUpButton])
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        return sv
    }()
    
    // 이메일 찾기 버튼
    public let emailSearchButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("이메일 찾기", for: .normal)
        bt.setTitleColor(.mainTextColor, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 12, family: .Medium)
        return bt
    }()
    
    // 비밀번호 찾기 버튼
    public let passwordSearchButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("비밀번호 찾기", for: .normal)
        bt.setTitleColor(.mainTextColor, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 12, family: .Medium)
        return bt
    }()
    
    // 회원가입 버튼
    public let signUpButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("회원가입", for: .normal)
        bt.setTitleColor(.mainTextColor, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 12, family: .Medium)
        return bt
    }()
    
    // 이메일 찾기 버튼, 비밀번호 찾기 버튼, 계정 찾기 버튼을 나누기 위한 경계선1
    public let seperateView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.clipsToBounds = true
        return view
    }()
    
    // 이메일 찾기 버튼, 비밀번호 찾기 버튼, 계정 찾기 버튼을 나누기 위한 경계선2
    public let seperateView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.clipsToBounds = true
        return view
    }()
    
    // 로그인 버튼
    public var loginButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("로그인", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
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
    
    // required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [titleLabel, emailLabel, emailTextField, passwordLabel, passwordTextField, stackView, loginButton]
            .forEach { self.addSubview($0) }
    }

    // Layout 설정
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
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
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(65)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
        
        seperateView1.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        
        seperateView2.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(stackView.snp.bottom).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(115)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
} // closed LoginView
