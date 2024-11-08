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
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    private let disposeBag: DisposeBag = DisposeBag()
    
    public override func loadView() {
        self.view = recommendListView
    } // closed loadView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setupTableView()
        
        self.navigationItem.titleView = recommendListView.progressView
        
        let items = [
            Item.recommendItem(RecommendItem(emoji: "😄", desc: "기쁨", isChecked: false)),
            Item.recommendItem(RecommendItem(emoji: "😭", desc: "슬픔", isChecked: false)),
            Item.recommendItem(RecommendItem(emoji: "😡", desc: "화남", isChecked: false)),
            Item.recommendItem(RecommendItem(emoji: "😐", desc: "차분", isChecked: false)),
        ]
        
        recommendListView.tableView.snp.updateConstraints { make in
            make.height.equalTo(items.count * 120)
        }
        
        let section = Section.recommend
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        self.dataSource.apply(snapshot)
        
    } // closed viewDidLoad
    
    private func setupTableView() {
        dataSource = UITableViewDiffableDataSource(tableView: recommendListView.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .recommendItem(let recommendData):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.ID, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
                cell.configure(emoji: recommendData.emoji, desc: recommendData.desc, isChecked: recommendData.isChecked)
                cell.selectionStyle = .none
                return cell
            }
        })
    } // closed setupTableView
    
    private func bindView() {
        
        recommendListView.completeButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                let items = [
                    Item.recommendItem(RecommendItem(emoji: "😄", desc: "혼자", isChecked: false)),
                    Item.recommendItem(RecommendItem(emoji: "😭", desc: "친구", isChecked: false)),
                    Item.recommendItem(RecommendItem(emoji: "😡", desc: "가족", isChecked: false)),
                    Item.recommendItem(RecommendItem(emoji: "😐", desc: "연인", isChecked: false)),
                ]
                
                
                // snapshot 초기화 및 새로운 섹션과 아이템 추가
                self.snapshot.deleteAllItems()
                let section = Section.recommend
                self.snapshot.appendSections([section])
                self.snapshot.appendItems(items, toSection: section)
                
                // 변경된 snapshot을 dataSource에 적용
                self.dataSource.apply(self.snapshot)
                
                // 테이블 높이 업데이트
                self.recommendListView.tableView.snp.updateConstraints { make in
                    make.height.equalTo(items.count * 120)
                }
                
            }
            .disposed(by: disposeBag)
        
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
    
    
} // closed RecommendListViewController
