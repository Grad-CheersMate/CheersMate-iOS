//
//  SearchViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/26/24.
//

// MARK: - 사용자가 원하는 상품을 검색하기 위한 화면

import UIKit
import RxSwift
import RxCocoa

public final class SearchViewController: UIViewController {
    
    // 프로퍼티
    private let searchView = SearchView()
    private let viewModel: SearchViewModelProtocol
    private var isSnapshotEmpty = true // 스냅샷에 아이템의 적용 여부 체크
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = searchView
    }
    
    // init
    public init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        bindView()
        bindViewModel()
        becameSearchBarFirstResponder()
    }
    
    // viewWillAppear
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isSnapshotEmpty { // 스냅샷에 아이템이 적용되지 않았다면
            becameSearchBarFirstResponder() // 키보드를 올리기
        }
    }
    
    // 네비게이션 설정
    private func setupNavi() {
        self.navigationItem.titleView = searchView.searchBar // 서치바 등록
        self.navigationItem.rightBarButtonItem = searchView.rightBarButtonItem // 뒤로가기 취소 버튼 등록
    }
    
    // 바인드 뷰
    private func bindView() {
        // 스크롤을 감지하고 현재 셀에 보여지는 아이템 여부에 따라서 keyboardDismissMode 설정
        searchView.collectionView.rx.didScroll
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                !isSnapshotEmpty ? (searchView.collectionView.keyboardDismissMode = .onDrag) : (searchView.collectionView.keyboardDismissMode = .none)
            })
            .disposed(by: disposeBag)
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
        // 인풋
        let input = SearchViewModel.Input(
            cancelButtonTapped: searchView.rightBarButton.rx.tap.asObservable(),
            viewWillDisapper: self.rx.methodInvoked(#selector(UIViewController.viewWillDisappear(_:))).map { _ in },
            searchButtonTapped: searchView.searchBar.rx.searchButtonClicked.withLatestFrom(searchView.searchBar.rx.text.orEmpty).asObservable(),
            prefetchItems: searchView.collectionView.rx.prefetchItems.asObservable()
        )
        
        // 아웃풋
        let output = viewModel.transform(input: input)
        
        // 취소 버튼을 눌렀을 때 화면을 홈으로 전환
        output.dismissTrigger
            .bind(onNext: { [weak self] _ in
                self?.tabBarController?.selectedIndex = 0 // 탭 바 0번은 메인화면
                let emptySnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                self?.searchView.dataSource?.apply(emptySnapshot, animatingDifferences: false)
                self?.searchView.searchBar.text = "" // 검색 텍스트 초기화
                self?.isSnapshotEmpty = true // 스냅샷 상태를 빈 상태로 변경
                self?.resignSearchBarFirstResponder() 
            })
            .disposed(by: disposeBag)
        
        // 받아온 아이템을 스냅샷에 적용
        output.productList
            .filter { !$0.isEmpty }
            .bind(onNext: { [weak self] liquors in
                guard let self = self else { return }
                let items = liquors.map { Item.productItem(Liquor(id: $0.id, name: $0.name, volume: $0.volume, type: $0.category, imageUrl: $0.imageUrl)) }
                let section = Section.category
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([section])
                snapshot.appendItems(items, toSection: section)
                searchView.dataSource?.apply(snapshot)
                resignSearchBarFirstResponder()
                isSnapshotEmpty = false
            })
            .disposed(by: disposeBag)
        
        // 스크롤 상단 이동
        output.scrollToTopTrigger
            .filter{ $0 }
            .bind(onNext: { [weak self] condition in
                guard let self = self else { return }
                if !isSnapshotEmpty {
                    searchView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: condition)
                }
            })
            .disposed(by: disposeBag)
        
        
        
    } // closed bindViewModel
    
    
} // closed SearchViewController

extension SearchViewController {
    // 키보드 내리기
    private func resignSearchBarFirstResponder() {
        if searchView.searchBar.isFirstResponder {
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    // 키보드 올리기
    private func becameSearchBarFirstResponder() {
        if !searchView.searchBar.isFirstResponder {
            searchView.searchBar.becomeFirstResponder()
        }
    }
    
} // closed extension
