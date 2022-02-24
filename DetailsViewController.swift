//
//  DetailsViewController.swift
//  Za Hunter
//
//  Created by Briana Pacheco on 2/14/22.
//

import UIKit

class DetailsViewController: UIViewController
{

    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    var currentPizzaShop: PizzaShop!
    
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        shopName.text = currentPizzaShop.name
        address.text = currentPizzaShop.address
        

    }

    @IBAction func onDismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
}
