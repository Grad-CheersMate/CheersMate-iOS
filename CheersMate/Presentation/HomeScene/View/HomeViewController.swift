//
//  HomeViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit
import RxSwift
import RxCocoa

public struct Category: Hashable {
    let imageName: String
    let title: String
    let productType: ProductType
}

public final class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
    private let viewModel: HomeViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // init
    public init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // loadView
    public override func loadView() {
        self.view = homeView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        applySnapshot()
        bindView()
        bindViewModel()
    }
    
    // 바인드 뷰
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
                weatherVC.hidesBottomBarWhenPushed = true // 네비게이션에 Push할 때 탭 바를 화면에서 제거
                self?.navigationController?.pushViewController(weatherVC, animated: true)
                Haptics.shared.generateHaptics(style: .medium)
            })
            .disposed(by: disposeBag)
        
        // 카테고리 아이템을 클릭했을 때
        homeView.collectionView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                let homeItem = self?.homeView.dataSource.itemIdentifier(for: indexPath)
                switch homeItem {
                case .categoryItem(let item):
                    let categoryVC = CategoryTabmanViewCotroller(productType: item.productType)
                    categoryVC.hidesBottomBarWhenPushed = true
                    self?.navigationController?.pushViewController(categoryVC, animated: true)
                    Haptics.shared.generateHaptics(style: .medium)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    // bindViewModel
    private func bindViewModel() {
        let input = HomeViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.bestLiquors
            .map { Array($0.prefix(8)) }
            .bind(onNext: { [weak self] liquors in
                guard let self = self else { return }
                
                let bestItems = liquors.map { HomeItem.bestItem($0) }
                let bestSection = HomeSection.best("지금 가장 인기있는")
                
                if !self.snapshot.sectionIdentifiers.contains(bestSection) {
                    self.snapshot.appendSections([bestSection])
                }
    
                snapshot.appendItems(bestItems, toSection: bestSection)
                homeView.dataSource.apply(snapshot, animatingDifferences: true)
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
    
    // applySnapshot
    private func applySnapshot() {
        let categories = [Category(imageName: "beer", title: "맥주", productType: .beer),
                          Category(imageName: "wine", title: "와인", productType: .wine),
                          Category(imageName: "whiske", title: "위스키", productType: .wishke),
                          Category(imageName: "soju", title: "소주", productType: .soju),
                          Category(imageName: "riceWine", title: "막걸리", productType: .riceWine),
                          Category(imageName: "sake", title: "전통주", productType: .sake)]
        
        let categoryItems = categories.map { HomeItem.categoryItem($0) }
        let categorySection = HomeSection.category("카테고리")
        
        snapshot.appendSections([categorySection])
        snapshot.appendItems(categoryItems, toSection: categorySection)
        
        homeView.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
} // closed HomeViewController
