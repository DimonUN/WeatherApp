//
//  ThreeHourForcastTableViewCell.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 31.08.2022.
//

import UIKit

protocol Updatable {
    func updateData()
}
///Первая секция таблицы, в которой раслопожена одна ячейка с коллекцией
///с горизонтальным скроллом прогноза по часам
final class ThreeHourForcastTableViewCell: UITableViewCell {
    // MARK: - Properties
    private var dataSource: UICollectionViewDataSource?
    private var delegate: UICollectionViewDelegateFlowLayout?
    private enum CollectionReuseIdentifiers: String {
        case threeHourForcat
    }
    ///Коллекция
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.toAutoLayout()
        return collectionView
    }()
    // MARK: - Methods
    ///Настройка UI
    private func setupUI() {
        contentView.addSubviews(collectionView)
    }
    ///Настройка констрейнтов
    private func setupConstraints() {
        [
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 134.0)
        ].forEach { $0.isActive = true }
    }
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
        collectionView.register(
            ThreeHourForcastCollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionReuseIdentifiers.threeHourForcat.rawValue
        )
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Interface
    func setup(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegateFlowLayout) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
}
// MARK: - Extension Updatable
///Вызывается из MainScreenView
extension ThreeHourForcastTableViewCell: Updatable {
    func updateData() {
        self.collectionView.reloadData()
    }
}
