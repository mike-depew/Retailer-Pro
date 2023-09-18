//  ProductTableViewCell.swift
//  RetailerPro by Mike Depew

import UIKit


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

        // Set the image directly, rather than using AlamofireImage
        if let imageURL = URL(string: product.image) {
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                productImageView.image = image
            }
        }
    }
}
