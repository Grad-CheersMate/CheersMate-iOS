//
//  IntroView.swift
//  CheersMate
//
//  Created by 재훈 on 11/30/24.
//

// MARK: - 사용자가 앱을 시작했을 때 처음으로 보여지는 화면. 로고 및 로그인 선택지를 제공.

import UIKit

public final class IntroView: UIView {
    
    // 로고 이미지 뷰
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = .cheersMate
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    // 이메일로 로그인하기 버튼
    public var emailLoginButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("이메일로 로그인하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = .gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 15
        bt.backgroundColor = .buttonAbleColor
        return bt
    }()
    
    // 카카오톡으로 로그인하기 버튼
    public let kakaoLoginImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.layer.cornerRadius = 15
        v.image = .kakaoLogin
        v.clipsToBounds = true
        return v
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
        [logoImageView, emailLoginButton, kakaoLoginImageView].forEach { self.addSubview($0) }
    }

    // Layout 설정
    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            //make.top.equalTo(safeAreaLayoutGuide).inset(220)
            make.leading.trailing.equalToSuperview().inset(50)
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(logoImageView.snp.height)
        }
        
        emailLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoLoginImageView.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        kakaoLoginImageView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
} // closed IntroView
