//  ProductTableViewCell.swift
//  RetailerPro by Mike Depew

import UIKit
import AlamofireImage


class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
  //  @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "\(product.price) USD"
        categoryLabel.text = product.category

        // Use AlamofireImage to fetch and cache the image
        if let imageURL = URL(string: product.image) {
            productImageView.af.setImage(withURL: imageURL)
        }
    }
}
