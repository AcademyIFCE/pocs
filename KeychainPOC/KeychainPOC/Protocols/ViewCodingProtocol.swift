//
//  ViewCodingProtocol.swift
//  KeychainPOC
//
//  Created by Thiago Henrique on 11/08/22.
//

import Foundation

protocol ViewCoding {
    func addViewsInHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
    func buildLayout()
}

extension ViewCoding {
    func setupAditionalConfiguration() {}
    
    func buildLayout() {
        addViewsInHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
}
