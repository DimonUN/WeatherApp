//
//  DateCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 25.11.2022.
//

import UIKit

final class DateCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    ///Лэйбл с датой
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.toAutoLayout()
        return dateLabel
    }()
    ///View фона
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.layer.cornerRadius = 18.0
        backView.toAutoLayout()
        return backView
    }()
    // MARK: - Methods
    private func setupUI() {
        contentView.addSubviews(backView, dateLabel)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backView.heightAnchor.constraint(equalToConstant: 36.0),
            backView.widthAnchor.constraint(equalToConstant: 88.0),

            dateLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
        ])
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Interface
    ///Настройка ячейки
    func setupCell(forSelectState select: Bool, withText text: String) {
        if select {
            dateLabel.textColor = Colors.textWhite.color
            dateLabel.attributedText = NSMutableAttributedString(
                string: text,
                attributes: Fonts.H3.install.attributes
            )
            dateLabel.font = Fonts.H3.install.font
            backView.backgroundColor = Colors.blue.color
        } else {
            dateLabel.textColor = Colors.textBlack.color
            dateLabel.attributedText = NSMutableAttributedString(
                string: text,
                attributes: Fonts.H3.install.attributes
            )
            dateLabel.font = Fonts.H3.install.font
            backView.backgroundColor = nil
        }
    }
}
