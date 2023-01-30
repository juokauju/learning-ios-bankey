//
//  AccountSummaryCell.swift
//  Udemy-Bankey
//
//  Created by jimi bird on 2023-01-26.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString {
                return CurrencyFormatter().makeAttributedCurrency(balance)
            }
    }
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    private let typeLabel = UILabel()
    private let underlineView = UIView()
    private let nameLabel = UILabel()
    
    private let balanceStackView = UIStackView()
    private let balanceLabel = UILabel()
    private let balanceAmountLabel = UILabel()
    
    private let chevronImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    private func setup() {
        setTypeLabel()
        setUnderlineView()
        setNameLabel()
        setBalanceStackView()
        setChevronImageView()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            // Type Label
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            // Underline View
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            
            // Name label
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            // Balance stack view
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            // Chevron image view
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func setTypeLabel() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        
        contentView.addSubview(typeLabel)
    }
    
    private func setUnderlineView() {
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        contentView.addSubview(underlineView)
    }
    
    private func setNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = "Account name"
        
        contentView.addSubview(nameLabel)
    }
    
    private func setBalanceStackView() {
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        setBalanceLabel()
        setBalanceAmountLabel()

        contentView.addSubview(balanceStackView)
    }
    
    private func setBalanceLabel() {
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.text = "Some balance"
        balanceStackView.addArrangedSubview(balanceLabel)
    }
    
    private func setBalanceAmountLabel() {
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.text = "$XX,XXX.XX"
        balanceStackView.addArrangedSubview(balanceAmountLabel)
    }
    
    private func setChevronImageView() {
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")!
            .withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        
        contentView.addSubview(chevronImageView)
    }
}

extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
