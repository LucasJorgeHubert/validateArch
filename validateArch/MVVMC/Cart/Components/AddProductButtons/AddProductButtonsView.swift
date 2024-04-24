//
//  AddProductButtons.swift
//  validateArch
//
//  Created by Lucas Hubert on 23/04/24.
//

import UIKit
import NatDS

class AddProductButtonsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dividerBar: Divider = {
        let divider = Divider()
        divider.configure(style: .middle)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    lazy var squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .body1)
        label.text = "ou"
        return label
    }()
    
    lazy var searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .body1)
        label.text = "Buscar"
        return label
    }()
    
    lazy var searchButton: NatIconButton = {
        let btn = NatIconButton(style: .standardDefault, size: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.configure(icon: NatDS.getIcon(.outlinedActionSearch))
        btn.configure(background: .float)
        return btn
    }()
    
    lazy var promoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var promoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .body1)
        label.text = "Promoções"
        return label
    }()
    
    lazy var promoButton: NatIconButton = {
        let btn = NatIconButton(style: .standardDefault, size: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.configure(icon: NatDS.getIcon(.outlinedFinancePromotion))
        btn.configure(background: .float)
        return btn
    }()
    
    lazy var rowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setup() {
        addSubview(dividerBar)
        
        squareView.addSubview(orLabel)
        addSubview(squareView)
        
        searchView.addSubview(searchButton)
        searchView.addSubview(searchLabel)
        
        promoView.addSubview(promoButton)
        promoView.addSubview(promoLabel)
        
        rowStackView.addArrangedSubview(searchView)
        rowStackView.addArrangedSubview(promoView)
        
        addSubview(rowStackView)
        
        NSLayoutConstraint.activate([
            dividerBar.topAnchor.constraint(equalTo: self.topAnchor, constant: NatSizes.small),
            dividerBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dividerBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            squareView.topAnchor.constraint(equalTo: dividerBar.bottomAnchor, constant: -NatSpacing.small),
            squareView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            squareView.heightAnchor.constraint(equalToConstant: NatSizes.semi),
            squareView.widthAnchor.constraint(equalToConstant: NatSizes.semi),
            
            orLabel.centerXAnchor.constraint(equalTo: squareView.centerXAnchor),
            orLabel.centerYAnchor.constraint(equalTo: squareView.centerYAnchor),
            
            searchButton.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchButton.centerXAnchor.constraint(equalTo: searchView.centerXAnchor),
            
            searchLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: NatSizes.tiny),
            searchLabel.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            searchLabel.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor),
            
            promoButton.topAnchor.constraint(equalTo: promoView.topAnchor),
            promoButton.centerXAnchor.constraint(equalTo: promoView.centerXAnchor),
            
            promoLabel.topAnchor.constraint(equalTo: promoButton.bottomAnchor, constant: NatSizes.tiny),
            promoLabel.bottomAnchor.constraint(equalTo: promoView.bottomAnchor),
            promoLabel.centerXAnchor.constraint(equalTo: promoButton.centerXAnchor),
            
            rowStackView.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: NatSpacing.tiny),
            rowStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: NatSizes.huge),
            rowStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rowStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rowStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
}
