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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    // 바인드 뷰
    private func bindView() {
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
        let input = ProductListViewModel.Input()
        
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

