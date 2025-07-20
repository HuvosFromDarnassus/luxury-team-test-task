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
        button.setTitleColor(Colors.Common.commonBlack.color, for: .normal)
        button.backgroundColor = .clear
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        return button
    }()
    private var rightButtonAction: (() -> Void)?

    // MARK: Initializers

    init(
        title: String,
        rightButtonTitle: String? = nil,
        rightButtonAction: (() -> Void)? = nil
    ) {
        titleLabel.text = title
        self.rightButtonAction = rightButtonAction
        super.init(frame: .zero)
        setupRightButton(title: rightButtonTitle)
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
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
            $0.trailing.equalTo(rightButton.snp.leading).inset(-16)
        }
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
        }
    }

    // MARK: Actions

    @objc
    private func didTapRightButton() {
        rightButtonAction?()
    }

    // MARK: Private

    private func setupRightButton(title: String?) {
        guard let title else { return }
        rightButton.setTitle(title, for: .normal)
        rightButton.titleLabel?.font = Fonts.Montserrat.semiBold.font(size: 11)
        rightButton.isHidden = false
    }

}
