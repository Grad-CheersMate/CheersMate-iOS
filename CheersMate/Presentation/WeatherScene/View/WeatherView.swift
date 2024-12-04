//
//  WeatherView.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

import UIKit
import Kingfisher

public final class WeatherView: UIView {
    // 스크롤 뷰
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.isDirectionalLockEnabled = true
        sv.alwaysBounceVertical = true
        return sv
    }()
    // 메인 컨테이너 뷰 - 스크롤 뷰와 영역을 맞추기 위함
    private let mainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    // 날씨 메인 컨테이너 뷰: 이미지 + 날짜 + 수집시간 + 온도
    private let weatherMainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    // 날씨 로고 이미지 뷰
    private let weatherImageView: UIImageView = {
        let v = UIImageView()
        v.image = .cloudy // 흐린날
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.kf.indicatorType = .activity
        return v
    }()
    // 온도 레이블
    private let tempLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainTextColor
        lb.text = "17.5 ℃"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 42, family: .Bold)
        lb.textAlignment = .left
        return lb
    }()
    // 지역 레이블
    private let locationLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainTextColor
        lb.text = "성남시 수정구"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 15, family: .Bold)
        lb.textAlignment = .left
        return lb
    }()
    // 날짜 레이블
    private let dateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .subTextColor
        lb.text = "2024년 11월 18일\n02:00"
        lb.setLineSpacing(spacing: 5)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    // 날씨 서브 컨테이너 뷰
    private let weatherSubContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    // 강수량 이미지 뷰
    private let precipitationImageView: UIImageView = {
        let v = UIImageView()
        v.image = .precipitation // 강수량
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        return v
    }()
    // 강수량 레이블
    private let precipitationLabel: UILabel = {
        let lb = UILabel()
        lb.text = "강수량\n0mm"
        lb.setLineSpacing(spacing: 5) // 위치를 마지막에 두면 레이블의 속성이 바뀔 수 있으니 가능한 먼저 호출
        lb.textColor = .subTextColor
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 12, family: .Medium)
        lb.textAlignment = .center
        return lb
    }()
    // 습도 이미지 뷰
    private let humidityImageView: UIImageView = {
        let v = UIImageView()
        v.image = .humidity // 습도
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        return v
    }()
    // 습도 레이블
    private let humidityLabel: UILabel = {
        let lb = UILabel()
        lb.text = "습도\n25%"
        lb.setLineSpacing(spacing: 5) // 위치를 마지막에 두면 레이블의 속성이 바뀔 수 있으니 가능한 먼저 호출
        lb.textColor = .subTextColor
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 12, family: .Medium)
        lb.textAlignment = .center
        return lb
    }()
    // 풍속 이미지 뷰
    private let windImageView: UIImageView = {
        let v = UIImageView()
        v.image = .wind // 풍속
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        return v
    }()
    // 풍속 레이블
    private let windLabel: UILabel = {
        let lb = UILabel()
        lb.text = "풍속\n0.5m/s"
        lb.textColor = .subTextColor
        lb.setLineSpacing(spacing: 5) // 위치를 마지막에 두면 레이블의 속성이 바뀔 수 있으니 가능한 먼저 호출
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 12, family: .Medium)
        lb.textAlignment = .center
        return lb
    }()
    // 영역을 구분하기 위한 뷰1
    public let seperateView1: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.clipsToBounds = true
        return view
    }()
    // 영역을 구분하기 위한 뷰2
    public let seperateView2: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.clipsToBounds = true
        return view
    }()
    // 강수량 서브 컨테이너
    private let precipitationContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    // 습도 서브 컨테이너
    private let humidityContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    // 풍속 서브 컨테이너
    private let windContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    // MARK: - 섹션 3
    // 추천 주류 메인 컨테이너
    private let recommendLiquorMainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    // 추천 주류 서브 컨테이너 1 - 좌측
    private let recommendLiquorFirstSubContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    // 영역을 구분하기 위한 뷰3
    public let seperateView3: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.clipsToBounds = true
        return view
    }()
    // 추천 주류 서브 컨테이너 2 - 우측
    private let recommendLiquorSecondSubContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    // 추천 주류 이미지 뷰 1
    private let recommendliquorFirstImageView: UIImageView = {
        let v = UIImageView()
        v.image = .saero
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.kf.indicatorType = .activity
        return v
    }()
    // 추천 주류 이미지 뷰 2
    private let recommendliquorSecondImageView: UIImageView = {
        let v = UIImageView()
        v.image = .saero
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.kf.indicatorType = .activity
        return v
    }()
    // 추천 주류 레이블 1
    public let recommendliquorFirstLabel: UILabel = {
        let lb = UILabel()
        lb.text = "주류명: 새로\n타입: 소주\n도수: 4.3"
        lb.setLineSpacing(spacing: 5) // 위치를 마지막에 두면 레이블의 속성이 바뀔 수 있으니 가능한 먼저 호출
        lb.textColor = .mainTextColor
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    // 추천 주류 레이블 2
    public let recommendliquorSecondLabel: UILabel = {
        let lb = UILabel()
        lb.text = "주류명: 새로\n타입: 소주\n도수: 4.3"
        lb.setLineSpacing(spacing: 5) // 위치를 마지막에 두면 레이블의 속성이 바뀔 수 있으니 가능한 먼저 호출
        lb.textColor = .mainTextColor
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    // init 설정
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // configure 설정
    public func configure(weather: Weather, firstLiquor: Liquor, secondLiquor: Liquor) {
        updateWeatherProperties(weather)
        updateLiquorProperties(id: 1, liquor: firstLiquor)
        updateLiquorProperties(id: 2, liquor: secondLiquor)
        dump(firstLiquor)
        dump(secondLiquor)
    }
    // 날씨 프로퍼티 업데이트
    private func updateWeatherProperties(_ weather: Weather) {
        tempLabel.text = "\(weather.temperature)℃" // 기온
        dateLabel.text = "\(weather.date)\n기준 \(weather.time)" // 날짜 그리고 시각
        humidityLabel.text = "습도\n\(weather.humidity)%" // 습도
        windLabel.text = "풍속\n\(weather.windSpeed)m/s" // 풍속
        precipitationLabel.text = "강수량\n\(weather.hourlyPrecipitation)mm" // 시간 당 강수량
        weatherImageView.image = UIImage(named: weather.condition) // 날씨 상태
    }
    // 추천 주류 프로퍼티 업데이트
    private func updateLiquorProperties(id: Int, liquor: Liquor) {
        guard let url = liquor.imageUrl else { return }
        if id == 1 {
            recommendliquorFirstImageView.kf.setImage(with: URL(string: url))
            recommendliquorFirstLabel.text = "주류명: \(liquor.name ?? "이름 정보 없음")\n타입: \(liquor.type ?? "타입 정보 없음")\n도수: \(liquor.volume ?? 0.0)"
        } else {
            recommendliquorSecondImageView.kf.setImage(with: URL(string: url))
            recommendliquorSecondLabel.text = "주류명: \(liquor.name ?? "이름 정보 없음")\n타입: \(liquor.type ?? "타입 정보 없음")\n도수: \(liquor.volume ?? 0.0)"
        }
    }
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        [scrollView].forEach { self.addSubview($0) }
        [mainContainerView].forEach { scrollView.addSubview($0) }
        // 컨테이너는 섹션을 의미
        [weatherMainContainerView, weatherSubContainerView, recommendLiquorMainContainerView].forEach { mainContainerView.addSubview($0) }
        [weatherImageView, dateLabel, locationLabel, tempLabel].forEach { weatherMainContainerView.addSubview($0) }
        [precipitationContainerView, seperateView1, humidityContainerView, seperateView2, windContainerView].forEach { weatherSubContainerView.addSubview($0) }
        [recommendLiquorFirstSubContainerView, seperateView3, recommendLiquorSecondSubContainerView].forEach { recommendLiquorMainContainerView.addSubview($0) }
        // 강수량, 습도, 풍속 컨테이너에 각 프로퍼티 추가
        [precipitationImageView, precipitationLabel].forEach { precipitationContainerView.addSubview($0) }
        [humidityImageView, humidityLabel].forEach { humidityContainerView.addSubview($0) }
        [windImageView, windLabel].forEach { windContainerView.addSubview($0) }
        // 추천 주류 컨테이너에 각 프로퍼티를 추가
        [recommendliquorFirstImageView, recommendliquorFirstLabel].forEach { recommendLiquorFirstSubContainerView.addSubview($0) }
        [recommendliquorSecondImageView, recommendliquorSecondLabel].forEach { recommendLiquorSecondSubContainerView.addSubview($0) }
    }
    // Layout 설정
    private func setupLayout() {
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        // 메인 컨테이너 뷰
        mainContainerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        // MARK: - 섹션 1
        // 날씨 메인 컨테이너
        weatherMainContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }
        // 날씨 이미지
        weatherImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(25)
            make.centerY.equalToSuperview()
        }
        // 온도 레이블
        tempLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(25)
            make.trailing.lessThanOrEqualTo(weatherImageView.snp.leading)
        }
        // 지역 레이블
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(25)
            make.trailing.lessThanOrEqualTo(weatherImageView.snp.leading)
        }
        // 날짜 레이블
        dateLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(locationLabel.snp.bottom)
            make.bottom.leading.equalToSuperview().inset(25)
            make.trailing.lessThanOrEqualTo(weatherImageView.snp.leading)
        }
        // MARK: - 섹션 2
        // 날씨 서브 컨테이너
        weatherSubContainerView.snp.makeConstraints { make in
            make.top.equalTo(weatherMainContainerView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(125)
        }
        // 첫 번째 컨테이너 뷰
        precipitationContainerView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        // 첫 번째 구분선
        seperateView1.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.top.bottom.equalToSuperview().inset(25)
            make.leading.equalTo(precipitationContainerView.snp.trailing) // 첫 번째 컨테이너뷰의 trailing과 연결
        }
        // 두 번째 컨테이너 뷰
        humidityContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(seperateView1.snp.trailing) // 첫 번째 구분선의 trailing과 연결
        }
        // 두 번째 구분선
        seperateView2.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.top.bottom.equalToSuperview().inset(25)
            make.leading.equalTo(humidityContainerView.snp.trailing) // 두 번째 컨테이너 뷰의 trailing과 연결
        }
        // 세 번째 컨테이너 뷰
        windContainerView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(seperateView2.snp.trailing) // 두 번째 구분선의 trailing과 연결
        }
        // MARK: - 첫 번째 컨테이너 <-> 첫 번째 구분선 <-> 두 번째 컨테이너 <-> 두 번째 구분선 <-> 세 번째 컨테이너 순서로 연결
        // 컨테이너 뷰의 너비를 동일하게 설정. 3등분
        precipitationContainerView.snp.makeConstraints { make in
            make.width.equalTo(humidityContainerView)
            make.width.equalTo(windContainerView)
        }
        // 각 컨테이너 뷰 내부의 요소 배치
        [precipitationImageView, humidityImageView, windImageView].forEach {
            $0.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(25)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(30)
            }
        }
        // 강수량 레이블
        precipitationLabel.snp.makeConstraints { make in
            make.top.equalTo(precipitationImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        // 습도 레이블
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
        }
        // 풍속 레이블
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(windImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
        }
        // MARK: - 섹션 3
        // 추천 주류 메인 컨테이너
        recommendLiquorMainContainerView.snp.makeConstraints { make in
            make.top.equalTo(weatherSubContainerView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(360)
            make.bottom.equalToSuperview().offset(-30)
        }
        // 추천 주류 서브 컨테이너 1
        recommendLiquorFirstSubContainerView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        // 세 번째 구분선
        seperateView3.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.top.bottom.equalToSuperview().inset(25)
            make.leading.equalTo(recommendLiquorFirstSubContainerView.snp.trailing) // 두 번째 컨테이너 뷰의 trailing과 연결
        }
        // 추천 주류 서브 컨테이너 2
        recommendLiquorSecondSubContainerView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(seperateView3.snp.trailing)
            make.width.equalTo(recommendLiquorFirstSubContainerView.snp.width)
        }
        // 추천 주류 이미지 1과 2
        [recommendliquorFirstImageView, recommendliquorSecondImageView].forEach {
            $0.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(25)
                make.centerX.equalToSuperview()
                make.height.equalTo(200)
            }
        }
        // 추천 주류 1 레이블
        recommendliquorFirstLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        recommendliquorFirstLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendliquorFirstImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
        }
        // 추천 주류 2 레이블
        recommendliquorSecondLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        recommendliquorSecondLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendliquorSecondImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
        }
        
    } // closed setupLayout
    
} // closed WeatherView
