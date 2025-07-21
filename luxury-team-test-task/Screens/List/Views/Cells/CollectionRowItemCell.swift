//
//  CollectionRowItemCell.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 20/07/2025.
//

import UIKit

final class CollectionRowItemCell: BaseCollectionViewCell {

    // MARK: Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Montserrat.semiBold.font(size: 12)
        label.textColor = Colors.Common.commonBlack.color
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    // MARK: BaseCollectionViewCell

    override func initilization() {
        setToDefaultState()
        contentView.clipsToBounds = true
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        setToDefaultState()
    }

    // MARK: Events

    func bind(viewData: CollectionItemViewData) {
        titleLabel.text = viewData.title
    }

    // MARK: Private

    private func setToDefaultState() {
        contentView.backgroundColor = Colors.Common.commonBackground.color
        contentView.layer.cornerRadius = 20
        titleLabel.text = nil
    }

}
