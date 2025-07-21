//
//  CollectionTableViewCell.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 20/07/2025.
//

import UIKit

final class CollectionTableViewCell: BaseTableViewCell {

    // MARK: Properties

    typealias CollectionDataSource = UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: CollectionRowItemCell.self)
        return collectionView
    }()

    private lazy var dataSource = makeDataSource()

    private var items: [CollectionViewItem] = [] {
        didSet {
            applySnapshot(items: items)
        }
    }

    // MARK: BaseTableViewCell

    override func initilization() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.equalToSuperview().inset(16)
            $0.top.trailing.equalToSuperview()
        }
    }

    // MARK: Events

    func bind(viewData: CollectionRowViewData) {
        viewData.collectionItems.forEach { items.append(.item(viewData: .init(title: $0))) }
    }

    // MARK: Private

    private func makeDataSource() -> CollectionDataSource {
        CollectionDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .item(let viewData):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CollectionRowItemCell.self)
                cell.bind(viewData: viewData)
                return cell
            }
        }
    }

    private func applySnapshot(items: [CollectionViewItem], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences) { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

}
