//  ProductDetailViewController.swift
//  RetailerPro | Created by Mike Depew

import UIKit

protocol ProductDetailDelegate: AnyObject {
    func didSelectProduct(_ product: Product)
}

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    weak var delegate: ProductDetailDelegate?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if a product is set
        if let product = product {
            configure(with: product)
        }
    }
    
    // Configure the UI elements with product data
    func configure(with product: Product) {
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        categoryLabel.text = product.category
        priceLabel.text = "\(product.price) USD"
        if let imageURL = URL(string: product.image) {
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                productImageView.image = image
            }
        
    }
}
   /* @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        // You can implement cart-related logic here
        // For example, add the selected product to a shopping cart
        if let product = product {
            delegate?.didSelectProduct(product)
        }
    }*/

}
