//
//  ViewModelProtocol.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 11.09.2022.
//

import Foundation

protocol ModelProtocol {}

protocol Setupable {
    func setup(withModel model: ModelProtocol)
}
