//
//  RecommendListViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/5/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class RecommendListViewController: UIViewController {
    
    private let recommendListView: RecommendListView = RecommendListView()
    private let viewModel: RecommendListViewModelProtocol
    private var dataSource: UITableViewDiffableDataSource<Section, Selection>!
    private let disposeBag: DisposeBag = DisposeBag()
    
    public override func loadView() {
        self.view = recommendListView
    } // closed loadView
    
    public init(viewModel: RecommendListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setupNavi()
        setupTableView()
        bindViewModel()
    } // closed viewDidLoad
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        self.navigationItem.titleView = recommendListView.progressView
    } // closed setupNavi
    
    // MARK: - 테이블 뷰 설정
    private func setupTableView() {
        dataSource = UITableViewDiffableDataSource(tableView: recommendListView.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.ID, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
            cell.configure(imageName: itemIdentifier.imageName, desc: itemIdentifier.desc)
            cell.selectionStyle = .none
            return cell
        })
    } // closed setupTableView
    
    // MARK: - 바인드 뷰
    private func bindView() {
        
        // 테이블의 셀이 클릭됬을 때
        recommendListView.tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                if let cell = self.recommendListView.tableView.cellForRow(at: indexPath) as? ListTableViewCell {
                    print(indexPath)
                    cell.itemSelected()
                }
                
            }
            .disposed(by: disposeBag)
        
    } // closed bindView
    
    // MARK: - 바인드 뷰 모델
    private func bindViewModel() {
        let input = RecommendListViewModel.Input(
            completeButtonTapped: recommendListView.completeButton.rx.tap)
        
        
        let output = viewModel.transform(input: input)
        
        output.pageNum
            .emit { [weak self] pageNum in
                self?.recommendListView.configure(page: pageNum) }
            .disposed(by: disposeBag)
        
        output.selections
            .emit { [weak self] items in
                guard let self = self else { return }
                let section = Section.recommend
                var snapshot = NSDiffableDataSourceSnapshot<Section, Selection>()
                snapshot.appendSections([section])
                snapshot.appendItems(items, toSection: section)
                self.dataSource.apply(snapshot)
                self.updateTableViewHeight(cellCount: items.count)
            }
            .disposed(by: disposeBag)
        
    } // closed bindViewModel
    
    private func updateTableViewHeight(cellCount: Int) {
        recommendListView.tableView.snp.updateConstraints { make in
            make.height.equalTo(cellCount * 120)
        }
    } // closed updateTableViewHeight
    
} // closed RecommendListViewController
