//
//  ListTableTitleHeaderView.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 20/07/2025.
//

import UIKit

final class ListTableTitleHeaderView: UIView {

    // MARK: Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Montserrat.bold.font(size: 18)
        label.textColor = Colors.Common.commonBlack.color
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.List.Search.Section.more, for: .normal)
        button.setTitleColor(Colors.Common.commonBlack.color, for: .normal)
        button.titleLabel?.font = Fonts.Montserrat.semiBold.font(size: 11)
        button.backgroundColor = .clear
        return button
    }()

    // MARK: Initializers

    init(title: String) {
        titleLabel.text = title
        super.init(frame: .zero)
        initialization()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialization() {
        backgroundColor = Colors.Common.commonWhite.color

        addSubviews(
            titleLabel,
            rightButton
        )

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(rightButton.snp.leading).inset(-16)
        }
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

}
