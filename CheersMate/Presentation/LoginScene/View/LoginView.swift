//
//  IntroView.swift
//  CheersMate
//
//  Created by 재훈 on 11/30/24.
//

// MARK: - 사용자가 앱을 시작했을 때 처음으로 보여지는 화면. 로고 및 로그인 선택지를 제공.

import UIKit
import Then
// 애플 로그인을 위한 프레임워크
import AuthenticationServices

public final class LoginView: UIView {
    // 버튼의 테두리 둥글기
    private static let buttonCornerRadius: CGFloat = 15
    
    // 로고 이미지 뷰
    private let logoImageView = UIImageView().then {
        $0.image = .cheersMate
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    // 애플 로그인 버튼
    public let appleLoginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black).then {
        $0.layer.cornerRadius = buttonCornerRadius
        $0.clipsToBounds = true
    }
    
    // 카카오톡으로 로그인하기 버튼
    public let kakaoLoginImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = buttonCornerRadius
        $0.image = .kakaoLogin
        $0.clipsToBounds = true
    }
    
    
    // 카카오톡으로 로그인하기 버튼
    public let kakaoLoginButton = UIButton(type: .custom).then {
        $0.setBackgroundImage(UIImage(resource: .kakaoLogin), for: .normal)
        $0.layer.cornerRadius = buttonCornerRadius
        $0.clipsToBounds = true
    }
    
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
        [logoImageView, appleLoginButton, kakaoLoginButton].forEach { self.addSubview($0) }
    }

    // Layout 설정
    private func setupLayout() {
        let buttonHeight = 55
        let buttonHorizonInset = 30
        
        logoImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(logoImageView.snp.height)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(buttonHorizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalToSuperview().inset(buttonHorizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
    }
    
} // closed LoginView
