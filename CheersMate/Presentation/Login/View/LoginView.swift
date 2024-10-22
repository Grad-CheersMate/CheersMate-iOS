//
//  LoginView.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

// MARK: - 사용자의 로그인 진행을 위한 로그인 뷰
import UIKit
import SnapKit

final class LoginView: UIView {
    // MARK: - 프로퍼티 설정
    // 메인 로고 이미지 뷰
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
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
        tf.placeholder = "gachon123@gachon.ac.kr"
        tf.keyboardType = .emailAddress
        tf.returnKeyType = .next
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
        tf.returnKeyType = .done
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
    // 이메일 찾기 버튼, 비밀번호 찾기 버튼, 계정 찾기 버튼을 묶는 스택 뷰
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailFindButton, seperateView1, passwordFindButton, seperateView2, signupButton])
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        return sv
    }()
    // 이메일 찾기 버튼
    private let emailFindButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("이메일 찾기", for: .normal)
        bt.setTitleColor(.textColor, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 12, family: .Medium)
        return bt
    }()
    // 비밀번호 찾기 버튼
    private let passwordFindButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("비밀번호 찾기", for: .normal)
        bt.setTitleColor(.textColor, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 12, family: .Medium)
        return bt
    }()
    // 회원가입 버튼
    private let signupButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("회원가입", for: .normal)
        bt.setTitleColor(.textColor, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 12, family: .Medium)
        bt.isEnabled = false
        return bt
    }()
    // 이메일 찾기 버튼, 비밀번호 찾기 버튼, 계정 찾기 버튼을 나누기 위한 경계선1
    let seperateView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.clipsToBounds = true
        return view
    }()
    // 이메일 찾기 버튼, 비밀번호 찾기 버튼, 계정 찾기 버튼을 나누기 위한 경계선2
    let seperateView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.clipsToBounds = true
        return view
    }()
    // 로그인 버튼
    let loginButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("로그인", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 8
        //bt.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.7843137255, blue: 0.8, alpha: 1)
        bt.backgroundColor = .mainColor
        return bt
    }()
    // 카카오 로그인 버튼
    let kakaoLoginImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.image = .kakaoLogin
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - 초기화
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
        
        [logoImageView, emailLabel, emailTextField, emailUnderLine, passwordLabel, passwordTextField, passwordUnderLine, loginButton, stackView, kakaoLoginImageView].forEach {
            self.addSubview($0)
        }
        
        
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(80)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(70)
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
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(passwordUnderLine.snp.bottom).offset(35)
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
            make.top.equalTo(stackView.snp.bottom).offset(130)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
        
        kakaoLoginImageView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
        
    } // closed setupLayout
    
} // closed main
