//
//  CategoryViewCotroller.swift
//  CheersMate
//
//  Created by 재훈 on 11/19/24.
//

// MARK: - 카테고리 화면에 필요한 상단 탭바를 생성하고 관리하는 뷰 컨트롤러

import UIKit
import Tabman
import Pageboy

public final class CategoryTabmanViewCotroller: TabmanViewController {
    // 프로퍼티
    private let productType: ProductType // 상품 타입
    private var viewControllers: [UIViewController] = []
    
    // init
    public init(productType: ProductType) {
        self.productType = productType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.title = "카테고리"
        // 카테고리: 베스트
        let bestVC = createCategoryViewControllers(productType: .best)
        // 카테고리: 맥주
        let beerVC = createCategoryViewControllers(productType: .beer)
        // 카테고리: 와인
        let wineVC = createCategoryViewControllers(productType: .wine)
        // 카테고리: 위스키
        let wishkeVC = createCategoryViewControllers(productType: .wishke)
        // 카테고리: 소주
        let sojuVC = createCategoryViewControllers(productType: .soju)
        // 카테고리: 막걸리
        let riceWineVC = createCategoryViewControllers(productType: .riceWine)
        // 카테고리: 전통주
        let sakeVC = createCategoryViewControllers(productType: .sake)
        
        // 상단 탭 바에 뷰 컨트롤러 등록
        viewControllers.append(contentsOf: [bestVC, beerVC, wineVC, wishkeVC, sojuVC, riceWineVC, sakeVC])
        // 탭맨 데이터 소스 설정
        self.dataSource = self
        // 탭맨 객체 생성
        let bar = TMBar.ButtonBar()
        setupTabBar(bar)
        // 상단에 탭맨 추가
        addBar(bar, dataSource: self, at: .top)
    }
    
    // 탭 바에 들어갈 뷰 컨트롤러를 카테고리(상품) 타입에 따라 생성
    private func createCategoryViewControllers(productType: ProductType) -> ProductListViewController {
        // MARK: - Data Layer
        let liquorNet = LiquorNetwork(manager: LiquorNetworkManager())
        let liquorRP = LiquorRepository(network: liquorNet)
        // MARK: - Domain Layer
        let categoryUC = CategoryUseCase(repository: liquorRP)
        let productListVM = ProductListViewModel(useCase: categoryUC, productType: productType)
        // MARK: - Presentation Layer
        let productListVC = ProductListViewController(viewModel: productListVM)
        return productListVC
    }

    // 탭 바 설정
    private func setupTabBar(_ bar : TMBar.ButtonBar) {
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed // 탭 바의 정렬 상태
        bar.layout.interButtonSpacing = 25 // 탭바 간격
        bar.layout.contentInset = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 0.0, right: 15.0) // 여백 설정
        //bar.layout.contentMode = .fit
       
        bar.backgroundView.style = .flat(color: .backgroundColor) // 스와이프할 때 효과
        bar.backgroundColor = .backgroundColor
        
        bar.buttons.customize { bt in
            bt.tintColor = .subTextColor // 선택되지 않은 탭의 색상
            bt.font = UIFont.gmarketSans(size: 15, family: .Medium) // 선택되지 않은 탭의 폰트
            bt.selectedTintColor = .mainColor // 선택된 탭의 색상
            bt.selectedFont = UIFont.gmarketSans(size: 15, family: .Medium) // 선택된 탭의 폰트
        }
        
        // 인디케이터(카테고리명 하단에 있는 바)
        bar.indicator.weight = .custom(value: 3) // 두께
        bar.indicator.tintColor = .mainColor // 색상
        bar.indicator.overscrollBehavior = .bounce // 가장자리에서 인디케이터의 바운스 효과
    }
    
    
} // closed CategoryViewCotroller

extension CategoryTabmanViewCotroller: PageboyViewControllerDataSource, TMBarDataSource {
    // 탭 바 페이지 수 설정
    public func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    // 인덱스에 따라 뷰 컨트롤러 전환
    public func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    // 디폴트 페이지 설정
    public func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        // 전달받은 productType에 따라 초기 선택 탭 설정
          switch productType {
          case .best:
              return .at(index: 0)
          case .beer:
              return .at(index: 1)
          case .wine:
              return .at(index: 2)
          case .wishke:
              return .at(index: 3)
          case .soju:
              return .at(index: 4)
          case .riceWine:
              return .at(index: 5)
          case .sake:
              return .at(index: 6)
          }
    }
    // 인덱스에 따라 제목 설정
    public func barItem(for bar: any Tabman.TMBar, at index: Int) -> any Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "베스트")
        case 1:
            return TMBarItem(title: "맥주")
        case 2:
            return TMBarItem(title: "와인")
        case 3:
            return TMBarItem(title: "위스키")
        case 4:
            return TMBarItem(title: "소주")
        case 5:
            return TMBarItem(title: "막걸리")
        default:
            return TMBarItem(title: "전통주")
        }
    }
} // closed extension
