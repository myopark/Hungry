//
//  SignUpViewController.swift
//  Hungry
//
//  Created by Nikole Kaufmann on 10/27/17.
//  Copyright © 2017 Melody park. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let email = userNameTextField.text
        let password = passwordTextField.text
        
        //Validate that all fields have info inputted
        if (firstName?.isEmpty)! || (lastName?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)! {
            //Display an alert message and return
            displayMessage(userMessage: "All fields are required to be filled in.")
            return
        }
        
        //Validate that password fields are matching
        if ((passwordTextField.text?.elementsEqual(confirmPasswordTextField.text!))! != true) {
            //Display alert message and return
            displayMessage(userMessage: "Password fields must match.")
            return
        }
        
        //Make sure passwords at least 6 characters in length
        if (password?.count)! < 6 {
            displayMessage(userMessage: "Passwords must be at least 6 characters in length.")
            return
        }

        //Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            if error == nil {
                self.displayMessage(userMessage: "You are successfully registered")
                myActivityIndicator.stopAnimating()
                myActivityIndicator.hidesWhenStopped = true
                //GO BACK TO HOME SCREEN
                
            } else {
                self.displayMessage(userMessage: "Registration Failed.. Please Try Again")
                myActivityIndicator.stopAnimating()
                myActivityIndicator.hidesWhenStopped = true
            }
        }

    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default){
                (action:UIAlertAction!) in
                print("Ok button tapper")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }

}
