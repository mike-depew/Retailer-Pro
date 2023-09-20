//  ProductTableViewCell.swift
//  RetailerPro | by Mike Depew

import UIKit
import AlamofireImage

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    //  @IBOutlet weak var descriptionLabel: UILabel!

    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "\(product.price) USD"
        categoryLabel.text = product.category
        if let imageURL = URL(string: product.image) {
            productImageView.af.setImage(withURL: imageURL)
        }
    }
}
