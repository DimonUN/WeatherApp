//
//  HeaderView.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 05.09.2022.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - Properties
    ///View в котором расположены остальные элементы хэдера
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.clipsToBounds = true
        contentView.toAutoLayout()
        return contentView
    }()
    ///Декоративная арка
    private lazy var decorArcView: UIView = {
        let decorArc = UIView()
        decorArc.layer.borderWidth = 3.0
        decorArc.layer.cornerRadius = 160.0
        decorArc.toAutoLayout()
        return decorArc
    }()
    ///View для обрезки нижних границ арки
    private lazy var cutterArcView: UIView = {
        let cutterArcView = UIView()
        cutterArcView.toAutoLayout()
        return cutterArcView
    }()
    ///Лэйбл с временем рассвета
    private lazy var timeOfSunriseLabel: UILabel = {
        let timeOfSunriseLabel = UILabel()
        timeOfSunriseLabel.toAutoLayout()
        return timeOfSunriseLabel
    }()
    ///Лэйбл с временем заката
    private lazy var timeOfSunsetLabel: UILabel = {
        let timeOfSunsetLabel = UILabel()
        timeOfSunsetLabel.toAutoLayout()
        return timeOfSunsetLabel
    }()
    ///Картинка рассвета
    private lazy var sunriseImageView: UIImageView = {
        let sunriseImageView = UIImageView()
        sunriseImageView.contentMode = .scaleAspectFit
        sunriseImageView.toAutoLayout()
        return sunriseImageView
    }()
    ///Картинка заката
    private lazy var sunsetImageView: UIImageView = {
        let sunsetImageView = UIImageView()
        sunsetImageView.contentMode = .scaleAspectFit
        sunsetImageView.toAutoLayout()
        return sunsetImageView
    }()
    ///View для раположения температурного диапазона
    private lazy var temperatureRangeContentView: UIView = {
        let temperatureRangeContentView = UIView()
        temperatureRangeContentView.toAutoLayout()
        return temperatureRangeContentView
    }()
    ///Лэйбл с данными минимальной температуры из температурного диапазона
    private lazy var temperatureRangeFromLabel: UILabel = {
        let temperatureRangeFromLabel = UILabel()
        temperatureRangeFromLabel.toAutoLayout()
        return temperatureRangeFromLabel
    }()
    ///Лэйбл с данными максимальной температуры из температурного диапазона
    private lazy var temperatureRangeToLabel: UILabel = {
        let temperatureRangeToLabel = UILabel()
        temperatureRangeToLabel.toAutoLayout()
        return temperatureRangeToLabel
    }()
    ///Лэйбл с данными текущей температры
    private lazy var currentTemperatureLabel: UILabel = {
        let currentTemperatureLabel = UILabel()
        currentTemperatureLabel.toAutoLayout()
        return currentTemperatureLabel
    }()
    ///Лэйбл с текущим прогнозом
    private lazy var currentForcastLabel: UILabel = {
        let currentForcastLabel = UILabel()
        currentForcastLabel.toAutoLayout()
        return currentForcastLabel
    }()
    ///View для размещения данных о УФ-индексе, ветре и вероятности осадков
    private lazy var threeElementsContentView: UIView = {
        let threeElementsContentView = UIView()
        threeElementsContentView.toAutoLayout()
        return threeElementsContentView
    }()
    ///Каринка с УФ-индексом
    private lazy var uvIndexImageView: UIImageView = {
        let uvIndexImageView = UIImageView()
        uvIndexImageView.contentMode = .scaleAspectFit
        uvIndexImageView.toAutoLayout()
        return uvIndexImageView
    }()
    ///Лэйбл с УФ-индексом
    private lazy var uvIndexLabel: UILabel = {
        let uvIndexLabel = UILabel()
        uvIndexLabel.toAutoLayout()
        return uvIndexLabel
    }()
    ///View для размещения данных о скорости ветра
    private lazy var windContentView: UIView = {
        let windContentView = UIView()
        windContentView.toAutoLayout()
        return windContentView
    }()
    ///Лэйбл скорости ветра
    private lazy var windLabel: UILabel = {
        let windLabel = UILabel()
        windLabel.toAutoLayout()
        return windLabel
    }()
    ///Каринка скорости ветра
    private lazy var windImageView: UIImageView = {
        let windImageView = UIImageView()
        windImageView.contentMode = .scaleAspectFit
        windImageView.toAutoLayout()
        return windImageView
    }()
    ///Каринка осадков
    private lazy var dropsImageView: UIImageView = {
        let dropsImageView = UIImageView()
        dropsImageView.contentMode = .scaleAspectFit
        dropsImageView.toAutoLayout()
        return dropsImageView
    }()
    ///Лэйбл с данными по осадкам
    private lazy var humidityLabel: UILabel = {
        let humidity = UILabel()
        humidity.toAutoLayout()
        return humidity
    }()
    ///Лэйбл с текущей датой
    private lazy var currentDateLabel: UILabel = {
        let currentDateLabel = UILabel()
        currentDateLabel.toAutoLayout()
        return currentDateLabel
    }()
    ///Знак градуса для текущей температуры
    private lazy var degreeCurrenView: UIView = {
        let degreeCurrenView = UIView()
        degreeCurrenView.layer.borderWidth = 1.0
        degreeCurrenView.layer.cornerRadius = 5.0
        degreeCurrenView.contentMode = .scaleAspectFit
        degreeCurrenView.toAutoLayout()
        return degreeCurrenView
    }()
    ///Знак градуса минимального значения из диапазона температур
    private lazy var degreeFromView: UIView = {
        let degreeView = UIView()
        degreeView.layer.borderWidth = 1.0
        degreeView.layer.cornerRadius = 5.0
        degreeView.contentMode = .scaleAspectFit
        degreeView.toAutoLayout()
        return degreeView
    }()
    ///Знак градуса максимального значения из диапазона температур
    private lazy var degreeToView: UIView = {
        let degreeView = UIView()
        degreeView.layer.borderWidth = 1.0
        degreeView.layer.cornerRadius = 5.0
        degreeView.contentMode = .scaleAspectFit
        degreeView.toAutoLayout()
        return degreeView
    }()
    // MARK: - Methods
    ///Настройка UI
    private func setupUI() {
        addSubviews(contentView)
        contentView.addSubviews(
            decorArcView,
            cutterArcView,
            timeOfSunriseLabel,
            timeOfSunsetLabel,
            sunriseImageView,
            sunsetImageView,
            temperatureRangeContentView,
            temperatureRangeFromLabel,
            temperatureRangeToLabel,
            currentTemperatureLabel,
            currentForcastLabel,
            threeElementsContentView,
            currentDateLabel,
            degreeCurrenView
        )
        threeElementsContentView.addSubviews(
            uvIndexLabel,
            uvIndexImageView,
            windContentView,
            humidityLabel,
            dropsImageView
        )
        windContentView.addSubviews(
            windLabel,
            windImageView,
            degreeFromView,
            degreeToView
        )
    }
    ///Настройка констрейнтов
    private func setupConstraints() {
        var width: CGFloat = 0
        if frame.width > 0 {
            width = frame.width - 60
        }

        [
            ///contentView
            contentView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 0
            ),
            contentView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: 0
            ),
            contentView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            decorArcView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10.0
            ),
            decorArcView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: 200.0
            ),
            decorArcView.centerXAnchor.constraint(equalTo: centerXAnchor),
            decorArcView.widthAnchor.constraint(equalToConstant: width),
            ///cutterArcView
            cutterArcView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            cutterArcView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            cutterArcView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            cutterArcView.topAnchor.constraint(
                equalTo: sunriseImageView.topAnchor,
                constant: -4.0
            ),
            ///timeOfSunriseLabel
            timeOfSunriseLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16.0
            ),
            timeOfSunriseLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -26.0
            ),
            ///sunriseImageView
            sunriseImageView.bottomAnchor.constraint(
                equalTo: timeOfSunriseLabel.topAnchor,
                constant: -6.0
            ),
            sunriseImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 24.0
            ),
            sunriseImageView.heightAnchor.constraint(
                equalToConstant: 18.0
            ),
            sunriseImageView.widthAnchor.constraint(
                equalToConstant: 18.0
            ),
            ///timeOfSunsetLabel
            timeOfSunsetLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16.0
            ),
            timeOfSunsetLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -26.0
            ),
            ///sunsetImageView
            sunsetImageView.bottomAnchor.constraint(
                equalTo: timeOfSunsetLabel.topAnchor,
                constant: -6.0
            ),
            sunsetImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24.0
            ),
            sunsetImageView.heightAnchor.constraint(
                equalToConstant: 18.0
            ),
            sunsetImageView.widthAnchor.constraint(
                equalToConstant: 18.0
            ),
            ///currentDateLabel
            currentDateLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -22.0
            ),
            currentDateLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            ///threeElementsContentView
            threeElementsContentView.bottomAnchor.constraint(
                equalTo: currentDateLabel.topAnchor,
                constant: -10.0
            ),
            threeElementsContentView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            threeElementsContentView.widthAnchor.constraint(
                greaterThanOrEqualToConstant: 188.0
            ),
            threeElementsContentView.heightAnchor.constraint(
                equalToConstant: 30.0
            ),
            ///uvIndexImageView
            uvIndexImageView.leadingAnchor.constraint(
                equalTo: threeElementsContentView.leadingAnchor
            ),
            uvIndexImageView.bottomAnchor.constraint(
                equalTo: threeElementsContentView.bottomAnchor,
                constant: -6.0
            ),
            uvIndexImageView.widthAnchor.constraint(
                equalToConstant: 21.0
            ),
            uvIndexImageView.heightAnchor.constraint(
                equalToConstant: 18.0
            ),
            ///uvIndexLabel
            uvIndexLabel.leadingAnchor.constraint(
                equalTo: uvIndexImageView.trailingAnchor,
                constant: 6.0
            ),
            uvIndexLabel.bottomAnchor.constraint(
                equalTo: threeElementsContentView.bottomAnchor,
                constant: -6.0
            ),
            ///windContentView
            windContentView.topAnchor.constraint(
                equalTo: threeElementsContentView.topAnchor
            ),
            windContentView.bottomAnchor.constraint(
                equalTo: threeElementsContentView.bottomAnchor
            ),
            windContentView.widthAnchor.constraint(
                greaterThanOrEqualToConstant: 62.0
            ),
            windContentView.leadingAnchor.constraint(
                equalTo: uvIndexLabel.trailingAnchor,
                constant: 19.0
            ),
            windContentView.trailingAnchor.constraint(
                equalTo: dropsImageView.leadingAnchor,
                constant: -19.0
            ),
            ///windImageView
            windImageView.leadingAnchor.constraint(
                equalTo: windContentView.leadingAnchor
            ),
            windImageView.bottomAnchor.constraint(
                equalTo: windContentView.bottomAnchor,
                constant: -6.0
            ),
            windImageView.widthAnchor.constraint(
                equalToConstant: 25.0
            ),
            windImageView.heightAnchor.constraint(
                equalToConstant: 16.0
            ),
            ///windLabel
            windLabel.leadingAnchor.constraint(
                equalTo: windImageView.trailingAnchor,
                constant: 6.0
            ),
            windLabel.trailingAnchor.constraint(
                equalTo: windContentView.trailingAnchor
            ),
            windLabel.bottomAnchor.constraint(
                equalTo: windContentView.bottomAnchor,
                constant: -6.0
            ),
            ///humidityLabel
            humidityLabel.trailingAnchor.constraint(
                equalTo: threeElementsContentView.trailingAnchor
            ),
            humidityLabel.bottomAnchor.constraint(
                equalTo: threeElementsContentView.bottomAnchor,
                constant: -6.0
            ),
            ///dropsImageView
            dropsImageView.trailingAnchor.constraint(
                equalTo: humidityLabel.leadingAnchor,
                constant: -6.0
            ),
            dropsImageView.bottomAnchor.constraint(
                equalTo: threeElementsContentView.bottomAnchor,
                constant: -6.0
            ),
            dropsImageView.widthAnchor.constraint(
                equalToConstant: 13.0
            ),
            dropsImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            ///currentForcastLabel
            currentForcastLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            currentForcastLabel.bottomAnchor.constraint(
                equalTo: threeElementsContentView.topAnchor,
                constant: -8.0
            ),
            ///currentTemperatureLabel
            currentTemperatureLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor,
                constant: -4.0
            ),
            currentTemperatureLabel.bottomAnchor.constraint(
                equalTo: currentForcastLabel.topAnchor,
                constant: -6.0
            ),
            ///temperatureRangeContentView
            temperatureRangeContentView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            temperatureRangeContentView.bottomAnchor.constraint(
                equalTo: currentTemperatureLabel.topAnchor,
                constant: -6.0
            ),
            temperatureRangeContentView.heightAnchor.constraint(
                equalToConstant: 20.0
            ),
            ///temperatureRangeFromLabel
            temperatureRangeFromLabel.leadingAnchor.constraint(
                equalTo: temperatureRangeContentView.leadingAnchor
            ),
            temperatureRangeFromLabel.centerYAnchor.constraint(
                equalTo: temperatureRangeContentView.centerYAnchor
            ),
            temperatureRangeToLabel.centerYAnchor.constraint(
                equalTo: temperatureRangeContentView.centerYAnchor
            ),
            temperatureRangeToLabel.leadingAnchor.constraint(
                equalTo: temperatureRangeFromLabel.trailingAnchor,
                constant: 6.0
            ),
            ///degreeCurrenView
            degreeCurrenView.leadingAnchor.constraint(
                equalTo: currentTemperatureLabel.trailingAnchor,
                constant: 1.0
            ),
            degreeCurrenView.topAnchor.constraint(
                equalTo: currentTemperatureLabel.topAnchor
            ),
            degreeCurrenView.heightAnchor.constraint(
                equalToConstant: 8.0
            ),
            degreeCurrenView.widthAnchor.constraint(
                equalToConstant: 8.0
            ),
            ///degreeFromView
            degreeFromView.leadingAnchor.constraint(
                equalTo: temperatureRangeFromLabel.trailingAnchor,
                constant: 1.0
            ),
            degreeFromView.topAnchor.constraint(
                equalTo: temperatureRangeFromLabel.topAnchor
            ),
            degreeFromView.heightAnchor.constraint(
                equalToConstant: 6.0
            ),
            degreeFromView.widthAnchor.constraint(
                equalToConstant: 6.0
            ),
            ///degreeToView
            degreeToView.leadingAnchor.constraint(
                equalTo: temperatureRangeToLabel.trailingAnchor,
                constant: 1.0
            ),
            degreeToView.trailingAnchor.constraint(
                equalTo: temperatureRangeContentView.trailingAnchor,
                constant: -4.0
            ),
            degreeToView.topAnchor.constraint(
                equalTo: temperatureRangeFromLabel.topAnchor
            ),
            degreeToView.heightAnchor.constraint(
                equalToConstant: 6.0
            ),
            degreeToView.widthAnchor.constraint(
                equalToConstant: 6.0
            )
        ].forEach { $0.isActive = true }
    }
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Interface
    ///Загрузка данных в хэдер
    lazy var loadDataInHeader: ((ModelProtocol) -> Void) = {
        [weak self] model in
        guard let self = self else { return }
        self.setup(withModel: model)
    }
    ///Загрузка прогноза в хэдер
    lazy var loadForcastInHeader: ((ModelProtocol) -> Void) = { [weak self] model in
        guard let self = self else { return }
        self.setup(withModel: model)
    }
}

extension HeaderView: Setupable {
    ///Прогрузка данных в хэдер
    func setup(withModel model: ModelProtocol) {
        if let model = model as? MainScreenModel.HeaderModel {
            contentView.backgroundColor = Colors.blue.color
            decorArcView.layer.borderColor = Colors.yellow.color.cgColor
            cutterArcView.backgroundColor = Colors.blue.color

            timeOfSunriseLabel.textColor = Colors.textWhite.color
            timeOfSunriseLabel.font = Fonts.body2.install.font

            timeOfSunsetLabel.textColor = Colors.textWhite.color
            timeOfSunsetLabel.font = Fonts.body2.install.font

            sunriseImageView.image = Icons.sunrise.icon
            sunriseImageView.setImageColor(color: model.sunriseImageViewColor)

            sunsetImageView.image = Icons.sunset.icon
            sunsetImageView.setImageColor(color: model.sunsetImageViewColor)

            temperatureRangeFromLabel.textColor = Colors.textWhite.color
            temperatureRangeFromLabel.font = Fonts.body.install.font

            temperatureRangeToLabel.textColor = Colors.textWhite.color
            temperatureRangeToLabel.font = Fonts.body.install.font

            currentTemperatureLabel.textColor = Colors.textWhite.color
            currentTemperatureLabel.font = Fonts.H4.install.font

            currentForcastLabel.textColor = Colors.textWhite.color
            currentForcastLabel.font = Fonts.body.install.font

            uvIndexLabel.textColor = Colors.textWhite.color
            uvIndexLabel.font = Fonts.body3.install.font

            windLabel.textColor = Colors.textWhite.color
            windLabel.font = Fonts.body3.install.font

            humidityLabel.textColor = Colors.textWhite.color
            humidityLabel.font = Fonts.body3.install.font

            currentDateLabel.textColor = Colors.yellow.color
            currentDateLabel.font = Fonts.body.install.font

            degreeCurrenView.layer.borderColor = Colors.white.color.cgColor

            degreeFromView.layer.borderColor = Colors.white.color.cgColor

            degreeToView.layer.borderColor = Colors.white.color.cgColor
        } else if let model = model as? HeaderForcastModel {
            ///
            timeOfSunriseLabel.attributedText = NSMutableAttributedString(
                string: model.timeOfSunrise,
                attributes: Fonts.body2.install.attributes
            )
            ///
            timeOfSunsetLabel.attributedText = NSMutableAttributedString(
                string: model.timeOfSunset,
                attributes: Fonts.body2.install.attributes
            )
            ///
            temperatureRangeFromLabel.attributedText = NSMutableAttributedString(
                string: model.temperatureRangeFrom,
                attributes: Fonts.body.install.attributes
            )
            ///
            temperatureRangeToLabel.attributedText = NSMutableAttributedString(
                string: "/" + model.temperatureRangeTo,
                attributes: Fonts.body.install.attributes
            )
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.94
            let attributes = [
                NSAttributedString.Key.kern: 3.06,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            ///
            currentTemperatureLabel.attributedText = NSMutableAttributedString(
                string: model.currentTemperature,
                attributes: attributes
            )
            ///
            currentForcastLabel.attributedText = NSMutableAttributedString(
                string: model.currentForcast,
                attributes: Fonts.body3.install.attributes
            )
            ///
            uvIndexLabel.attributedText = NSMutableAttributedString(
                string: model.uvIndex,
                attributes: Fonts.body3.install.attributes
            )
            uvIndexImageView.image = Images.cloudyGreySun.image
            ///
            windLabel.attributedText = NSMutableAttributedString(
                string: model.wind,
                attributes: Fonts.body3.install.attributes
            )
            windImageView.image = Images.windForHeader.image
            humidityLabel.attributedText = NSMutableAttributedString(
                string: model.humidity,
                attributes: Fonts.body3.install.attributes
            )
            dropsImageView.image = Images.dropsForHeader.image
            currentDateLabel.attributedText = NSMutableAttributedString(
                string: model.currentDate,
                attributes: Fonts.body.install.attributes
            )
        }
    }
}
