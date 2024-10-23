//
//  SignUpView.swift
//  CheersMate
//
//  Created by 재훈 on 10/23/24.
//

import UIKit

class SignUpView: UIView {
    // 이메일 주소 레이블
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.text = "이메일 주소"
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    // 이메일 입력 창
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.placeholder = "ex) gachon123@gachon.ac.kr"
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.clearButtonMode = .always
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    // 이메일 입력 창이 클릭됬을 때 표시하는 언더라인
    var emailUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    // 비밀번호 레이블
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.text = "비밀번호"
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    // 비밀번호 가리기 버튼
    private let secureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        return button
    }()
    // 비밀번호 입력 창
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.keyboardType = .numbersAndPunctuation
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.isSecureTextEntry = true
        tf.rightViewMode = .always
        tf.rightView = secureButton
        tf.rightView?.tintColor = .systemGray5
        //tf.rightViewRect(forBounds: .init(x: 0, y: 0, width: 7, height: 7))
        return tf
    }()
    // 비밀번호 입력 창이 클릭됬을 때 표시하는 언더라인
    var passwordUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    // 닉네임 주소 레이블
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.text = "닉네임"
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    // 닉네임 입력 창
    let nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.placeholder = ""
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.clearButtonMode = .always
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    // 닉네임 입력 창이 클릭됬을 때 표시하는 언더라인
    var nickNameUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    // 휴대폰 번호 레이블
    private let tellLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.text = "휴대폰 번호"
        label.font = UIFont.gmarketSans(size: 14, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    // 휴대폰 번호 입력 창
    let tellTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.placeholder = "ex) 010-1234-5678"
        tf.keyboardType = .numbersAndPunctuation
        tf.autocapitalizationType = .none
        tf.clearButtonMode = .always
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    // 휴대폰 번호 입력 창이 클릭됬을 때 표시하는 언더라인
    var tellUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    // 가입하기 버튼
    let signUpButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("가입하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 8
        //bt.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.7843137255, blue: 0.8, alpha: 1)
        bt.backgroundColor = .mainColor
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        
        [emailLabel, emailTextField, emailUnderLine, passwordLabel, passwordTextField, passwordUnderLine, nickNameLabel, nickNameTextField, nickNameUnderLine, tellLabel, tellTextField, tellUnderLine, signUpButton].forEach { self.addSubview($0) }
    
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        emailUnderLine.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailUnderLine.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        passwordUnderLine.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordUnderLine.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        nickNameUnderLine.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameUnderLine.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tellTextField.snp.makeConstraints { make in
            make.top.equalTo(tellLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        tellUnderLine.snp.makeConstraints { make in
            make.top.equalTo(tellTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.bottom).inset(100)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
    } // closed setupLayout
}
