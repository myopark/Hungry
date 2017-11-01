//
//  LogInViewController.swift
//  Hungry
//
//  Created by Nikole Kaufmann on 10/26/17.
//  Copyright © 2017 Melody park. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func logInButtonAction(_ sender: Any) {
        let email = usernameTextField.text
        let password = passwordTextField.text
        
        //Check to make to sure not empty
        if (email?.isEmpty)! || (password?.isEmpty)! {
            //Alert message
            displayMessage(userMessage: "Must enter required information for both fields")
            return
        }
        
        //Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        //Firebase Login
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            if error == nil {
                myActivityIndicator.stopAnimating()
                myActivityIndicator.hidesWhenStopped = true
                //MOVE TO HOME SCREEN
            } else {
                self.displayMessage(userMessage: "Registration Failed.. Please Try Again")
                myActivityIndicator.stopAnimating()
                myActivityIndicator.hidesWhenStopped = true
            }
        }
        
    }
    
    @IBAction func newUserButtonAction(_ sender: Any) {
        
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
