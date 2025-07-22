//
//  SymbolTableViewCell.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

import SDWebImage

final class SymbolTableViewCell: BaseTableViewCell {

    // MARK: Properties

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Colors.Common.commonGray.color.withAlphaComponent(0.3)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Montserrat.bold.font(size: 18)
        label.textColor = Colors.Common.commonBlack.color
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    private let favoritesImageView: UIImageView = {
        let imageView = UIImageView(image: Images.Cell.favoriteInactive.image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Montserrat.semiBold.font(size: 11)
        label.textColor = Colors.Common.commonBlack.color
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Montserrat.bold.font(size: 18)
        label.textColor = Colors.Common.commonBlack.color
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Montserrat.semiBold.font(size: 12)
        label.textColor = Colors.Status.statusGreen.color
        label.numberOfLines = 1
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        return view
    }()

    // MARK: BaseTableViewCell

    override func initilization() {
        selectionStyle = .none

        containerView.addSubviews(
            logoImageView,
            symbolLabel,
            favoritesImageView,
            nameLabel,
            priceLabel,
            changeLabel
        )
        contentView.addSubview(containerView)

        logoImageView.snp.makeConstraints {
            $0.size.equalTo(52)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(17)
        }
        changeLabel.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(100)
            $0.bottom.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(17)
        }
        symbolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
        }
        favoritesImageView.snp.makeConstraints {
            $0.leading.equalTo(symbolLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(symbolLabel)
            $0.size.equalTo(16)
            $0.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-8)
        }
        nameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(14)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
            $0.trailing.lessThanOrEqualTo(changeLabel.snp.leading).offset(-2)
        }
        containerView.snp.makeConstraints {
            $0.height.equalTo(68)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
        symbolLabel.text = nil
        favoritesImageView.image = Images.Cell.favoriteInactive.image
        nameLabel.text = nil
        priceLabel.text = nil
        changeLabel.text = nil
        containerView.backgroundColor = .clear
    }

    // MARK: Events

    func bind(viewData: ListItemViewData) {
        setupImages(with: viewData)
        symbolLabel.text = viewData.symbol
        nameLabel.text = viewData.name
        priceLabel.text = viewData.price
        changeLabel.text = viewData.change
        changeLabel.textColor = viewData.changeColor
        containerView.backgroundColor = viewData.cellBackgroundColor
    }

    private func setupImages(with viewData: ListItemViewData) {
        if let imageURL = viewData.imageURL {
            logoImageView.sd_setImage(with: imageURL)
        }
        favoritesImageView.image = viewData.isFavorite ? Images.Cell.favoriteActive.image : Images.Cell.favoriteInactive.image
    }

}
