//
//  HomeViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate struct Category {
    let mainImageText: String
    let descText: String
    let productType: ProductType
}

public final class HomeViewController: UIViewController {
    // 프로퍼티
    private let homeView = HomeView()
    private let viewModel: HomeViewModelProtocol
    private let disposeBag = DisposeBag()
    
    public init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // LoadView
    public override func loadView() {
        self.view = homeView
    }
    // ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupTableView()
        bindView()
        bindViewModel()
    }
    // 뷰 바인드
    private func bindView() {
        // 확인하기 버튼을 클릭했을 때 날씨 뷰로 이동
        homeView.weatherButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                // MARK: - Data Layer
                let weatherNet = WeatherNetwork(manager: WeatherNetworkManager())
                let weatherRP = WeatherRepository(network: weatherNet)
                // MARK: - Domain Layer
                let weatherUC = WeatherUseCase(repository: weatherRP)
                let weatherVM = WeatherViewModel(useCase: weatherUC)
                // MARK: - Presentation Layer
                let weatherVC = WeatherViewController(viewModel: weatherVM)
                self?.navigationController?.pushViewController(weatherVC, animated: true)
                Haptics.shared.generateHaptics(style: .medium)
            })
            .disposed(by: disposeBag)
    }
    
    // 뷰 모델 바인드
    private func bindViewModel() {
        // 셀이 클릭되었을 때, 해당 셀의 정보를 가져옴
        homeView.categoryTableView.rx.modelSelected(Category.self)
            .subscribe(onNext: { [weak self] model in
                let categoryVC = CategoryTabmanViewCotroller(productType: model.productType)
                self?.navigationController?.pushViewController(categoryVC, animated: true)
                Haptics.shared.generateHaptics(style: .medium)
            })
            .disposed(by: disposeBag)
    }
    
    // 네비게이션 설정
    private func setupNavi() {
        // 네비게이션 바의 왼쪽과 오른쪽 설정
        navigationItem.leftBarButtonItem = homeView.leftBarButtonItem
        navigationItem.rightBarButtonItem = homeView.rightBarButtonItem
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainTextColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // 테이블 뷰 설정
    private func setupTableView() {
        let items = Observable<[Category]>.just([
            Category(mainImageText: "best", descText: "베스트", productType: .best),
            Category(mainImageText: "beer", descText: "맥주", productType: .beer),
            Category(mainImageText: "wine", descText: "와인", productType: .wine),
            Category(mainImageText: "whiske", descText: "위스키", productType: .wishke),
            Category(mainImageText: "soju", descText: "소주", productType: .soju),
            Category(mainImageText: "riceWine", descText: "막걸리", productType: .riceWine),
            Category(mainImageText: "sake", descText: "전통주", productType: .sake)
        ])
        
        updateTableViewHeight(cellCount: 7)
        
        items
            .bind(to: homeView.categoryTableView.rx.items(cellIdentifier: CategoryTableViewCell.ID, cellType: CategoryTableViewCell.self)) { row, element, cell in
                cell.configure(imageText: element.mainImageText, descText: element.descText, productType: element.productType)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
    
    // 아이템 수에 따른 테이블 뷰 높이 제약 업데이트
    private func updateTableViewHeight(cellCount: Int) {
        homeView.categoryTableView.snp.updateConstraints { make in
            make.height.equalTo(cellCount * 90)
        }
    }
    
} // closed HomeViewController
