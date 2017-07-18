//
//  CustomBottomBar.swift
//  Noticar
//
//  Created by Tanut.leel on 11/18/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Material

class CustomBottomBar: BottomNavigationController {
    open override func prepare() {
        super.prepare()
        prepareTabBar()
    }
    
    private func prepareTabBar() {
        tabBar.depthPreset = .none
        tabBar.dividerColor = Color.grey.lighten3
    }
}
