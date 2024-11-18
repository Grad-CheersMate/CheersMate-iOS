//
//  WeatherViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 사용자의 날씨 맞춤 주류 추천 시스템
public final class WeatherViewController: UIViewController {
    // 프로퍼티
    private let weatherView = WeatherView()
    private let viewModel:  WeatherViewModelProtocol
    private let disposeBag = DisposeBag()
    // init
    public init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // LoadView
    public override func loadView() {
        self.view = weatherView
    }
    // ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "추천 결과"
        bindView()
        bindViewModel()
    }
    // 뷰 바인드
    private func bindView() {
 
    }
    // 뷰 모델 바인드
    private func bindViewModel() {
        // 인풋
        let input = WeatherViewModel.Input()
        // 아웃풋
        let output = viewModel.transform(input: input)
        
        output.responseWeatherData
            .bind { [weak self] weather, recommendData in
                guard let weather = weather else { return }
                self?.weatherView.configure(weather: weather, firstLiquor: recommendData[0].liquor, secondLiquor: recommendData[1].liquor)
            }
            .disposed(by: disposeBag)
    }
    
} // closed WeatherViewController
