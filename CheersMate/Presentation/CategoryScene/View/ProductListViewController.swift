//
//  ProductListViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/19/24.
//

// MARK: - 사용자에게 해당 상품 리스트를 모두 보여주는 화면

import UIKit
import RxSwift
import RxCocoa

public final class ProductListViewController: UIViewController {
    // 프로퍼티
    private let productListView = ProductListView()
    private let viewModel: ProductListViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = productListView
    }
    
    // init
    public init(viewModel: ProductListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
        print("viewDidLoad")
    }

    // 바인드 뷰
    private func bindView() {
        // 컬렉션 뷰의 아이템이 클릭됬을 때
        productListView.collectionView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                let item = self?.productListView.dataSource?.itemIdentifier(for: indexPath)
                switch item {
                case .productItem(let liquor):
                    print(liquor)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
        // 현재 페이지 정보
        let currentPage = BehaviorRelay<Int>(value: 0)
        // 컬렉션 뷰의 페이지네이션 구현
        productListView.collectionView.rx.prefetchItems
            .bind(onNext: { [weak self] indexPath in
                let snapshot = self?.productListView.dataSource?.snapshot()
                guard let lastIndexPath = indexPath.last, // 인덱스 정보
                      let section = self?.productListView.dataSource?.sectionIdentifier(for: lastIndexPath.section), // 현재 섹션 정보
                      let itemCountInSection = snapshot?.numberOfItems(inSection: section) else { return } // 현재 섹션의 아이템 수
                if lastIndexPath.row > itemCountInSection - 4 { // 인덱스 값이 전체 아이템 개수 -4 이상일 경우
                    currentPage.accept(currentPage.value + 1) // 페이지 증가
                }
            })
            .disposed(by: disposeBag)
        // 인풋
        let input = ProductListViewModel.Input(currentPage: currentPage.asObservable())
        //아웃풋
        let output = viewModel.transform(input: input)
        // 아이템 리스트에 스냅샷에 적용하기
        output.items
            .bind(onNext: { [weak self] liquors in
                let items = liquors.map { Item.productItem(Liquor(id: $0.id, name: $0.name, volume: $0.volume, type: $0.category, imageUrl: $0.imageUrl)) }
                let section = Section.category
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([section])
                snapshot.appendItems(items, toSection: section)
                self?.productListView.dataSource?.apply(snapshot)
            })
            .disposed(by: disposeBag)
    }
    
} // closed CategoryViewCotroller

