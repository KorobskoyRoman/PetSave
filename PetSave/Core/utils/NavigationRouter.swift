//
//  NavigationRouter.swift
//  PetSave
//
//  Created by Roman Korobskoy on 26.01.2023.
//

import SwiftUI

protocol NavigationRouter {
    associatedtype Data

    func navigate<T: View>(
        data: Data,
        view: (() -> T)?
    ) -> AnyView
}

struct AnimalDetailsRouter: NavigationRouter {
    typealias Data = AnimalEntity

    func navigate<T>(
        data: AnimalEntity,
        view: (() -> T)?
    ) -> AnyView where T : View {
        AnyView(
            NavigationLink(
                destination: AnimalDetailsView(animal: data)
            ) {
                view?()
            }
        )
    }
}
