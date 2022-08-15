//
//  SearchBarContainerView.swift
//  Directory App
//
//  Created by Kacper Cichosz on 06/08/2022.
//

import UIKit

class SearchBarContainerView: UIView {

    let searchBar: UISearchBar

    init(customSearchBar: UISearchBar) {
        self.searchBar = customSearchBar
        super.init(frame: CGRect.zero)

        addSubview(self.searchBar)
    }

    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.searchBar.frame = bounds
    }
}
