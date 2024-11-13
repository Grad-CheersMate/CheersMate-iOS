//
//  RecommendListViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/5/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class RecommendSelectionViewController: UIViewController {
    // MARK: - 프로퍼티 설정
    private let recommendListView: RecommendSelectionView = RecommendSelectionView()
    private let viewModel: RecommendSelectionViewModelProtocol
    private var dataSource: UITableViewDiffableDataSource<Section, Selection>!
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - 오버라이드 함수 설정
    public override func loadView() {
        self.view = recommendListView
    } // closed loadView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setupNavi()
        setupTableView()
        bindViewModel()
    } // closed viewDidLoad
    
    public init(viewModel: RecommendSelectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        self.navigationItem.titleView = recommendListView.progressView
    } // closed setupNavi
    
    // MARK: - 테이블 뷰 설정
    private func setupTableView() {
        dataSource = UITableViewDiffableDataSource(tableView: recommendListView.tableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendSelectionTableViewCell.ID, for: indexPath) as? RecommendSelectionTableViewCell else { return UITableViewCell() }
            cell.configure(imageName: item.title, desc: item.desc)
            cell.selectionStyle = .none
            return cell
        })
    } // closed setupTableView
    
    // MARK: - 바인드 뷰
    private func bindView() {

        
    } // closed bindView
    
    // MARK: - 바인드 뷰 모델
    private func bindViewModel() {
        let input = RecommendSelectionViewModel.Input(
            itemSelected: recommendListView.tableView.rx.itemSelected.asObservable(), // 테이블 뷰 셀 클릭
            completeButtonTapped: recommendListView.completeButton.rx.tap // 확인 버튼 클릭
        )
        
        let output = viewModel.transform(input: input)
        
        // 버튼 활성화 여부
        output.buttonEnable
            .bind { [weak self] condition in
                self?.recommendListView.setCompleteButtonEnabled(condition)
            }
            .disposed(by: disposeBag)
        
        // 셀의 상태 갱신
        output.updatedIndexPath
            .bind { [weak self] previousIndexPath, currentIndexPath, isDeselected in
                guard let self = self else { return }
                
                if let previousIndexPath = previousIndexPath, 
                   let previousCell = self.recommendListView.tableView.cellForRow(at: previousIndexPath) as? RecommendSelectionTableViewCell {
                    previousCell.resetCell()
                }
                
                if let currentIndexPath = currentIndexPath,
                   !isDeselected,
                   let currentCell = self.recommendListView.tableView.cellForRow(at: currentIndexPath) as? RecommendSelectionTableViewCell {
                    currentCell.isCellSelected(true)
                }
                Haptics.shared.generateHaptics(style: .medium)
            }
            .disposed(by: disposeBag)
        
        // 현재 페이지 타입에 맞춰서 로직처리
        output.currentPageType
            .bind { [weak self] type in
                self?.recommendListView.configure(type: type)
            }
            .disposed(by: disposeBag)
        
        // 선택지 배열을 가져오고 스냅샷 적용
        output.selections
            .bind(onNext: { [weak self] selections in
                guard let self = self else { return }
                self.recommendListView.setCompleteButtonEnabled(false)
                self.updateTableViewHeight(cellCount: selections.count)
                let section = Section.selection
                var snapshot = NSDiffableDataSourceSnapshot<Section, Selection>()
                snapshot.appendSections([section])
                snapshot.appendItems(selections, toSection: section)
                self.dataSource.apply(snapshot)
            })
            .disposed(by: disposeBag)
        
        output.recommendResponse
            .bind(onNext: { [weak self] response in
                if response.result && response.httpCode == 200 {
                    let recommendResultVC = RecommendResultViewController(data: response)
                    recommendResultVC.modalPresentationStyle = .overFullScreen
                    self?.present(recommendResultVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
    } // closed bindViewModel
    
    // MARK: - 테이블 뷰 높이 제약 업데이트
    private func updateTableViewHeight(cellCount: Int) {
        recommendListView.tableView.snp.updateConstraints { make in
            make.height.equalTo(cellCount * 120)
        }
    } // closed updateTableViewHeight
    
} // closed RecommendListViewController
