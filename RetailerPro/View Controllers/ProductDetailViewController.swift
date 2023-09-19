//  ProductDetailViewController.swift
//  RetailerPro | Created by Mike Depew

import UIKit
import Alamofire
import AlamofireImage

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
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        categoryLabel.text = product.category
        priceLabel.text = "\(product.price) USD"
        
        if let imageURL = URL(string: product.image) {
            // Use AlamofireImage to fetch and cache the image
            productImageView.af.setImage(withURL: imageURL)
        }
    }
   /* @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        // implement cart-related logic here
        // For example, add the selected product to a shopping cart
        if let product = product {
            delegate?.didSelectProduct(product)
        }
    }*/

}
