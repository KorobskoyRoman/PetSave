//
//  PetSaveTabNavigator.swift
//  PetSave
//
//  Created by Roman Korobskoy on 26.01.2023.
//

import SwiftUI

final class PetSaveTabNavigator: ObservableObject {
    @Published var currentTab: PetSaveTabType = .nearYou

    func switchTab(to tab: PetSaveTabType) {
        currentTab = tab
    }
}

extension PetSaveTabNavigator: Hashable {
    static func == (
        lhs: PetSaveTabNavigator,
        rhs: PetSaveTabNavigator
    ) -> Bool {
        lhs.currentTab == rhs.currentTab
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(currentTab)
    }
}
