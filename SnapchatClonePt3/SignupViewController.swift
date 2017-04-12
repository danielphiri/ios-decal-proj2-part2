//
//  SignupViewController.swift
//  SnapchatClonePt3
//
//  Created by SAMEER SURESH on 3/19/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
        TODO:
        
        Implement sign up functionality using the Firebase Auth create user function.
        If an error occurs, you should display an error message using a UIAlertController (e.g. if the password is less than 6 characters long). 
        Otherwise, using the user object that is returned from the createUser call, make a profile change request and set the user's displayName property to the name variable. 
        After committing the change request, you should perform a segue to the main screen using the identifier "signupToMain"
 
    */
    @IBAction func didAttemptSignup(_ sender: UIButton) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let name = nameField.text else { return }
        
        
        if email == "" || name == "" || password == "" {
            let alertController = UIAlertController(title: "Sign Up Error", message: "Please fill in all information.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                
                if error == nil {
                    //NSUserName() = nam
                    //CurrentUser.username = name
                   // user?.displayName = name
                    let changeReq = user!.profileChangeRequest()
                    changeReq.displayName = name
                    changeReq.commitChanges(completion:
                        { (err) in
                            if let err = err {
                                print(err)
                            } else {
                                
                            }
                        
                    })
                    //FIRAuth.auth()?.currentUser?.profileChangeRequest().displayName = name
                    
                    //FIRAuth.auth()?.currentUser?.profileChangeRequest().se
                   // var ref = Firebase(url: "https://.firebaseio.com/")
                   // var userNameRef = ref.childByAppendingPath("users/uid_0/user_name")
                   // userNameRef.setValue("Leeeeroy")
                    //FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid)
                    //FIRDatabase.database().reference().child("Users").child(FIRAuth.auth()!.currentUser!.uid)
                    
                    //FIRAuth.auth()?.currentUser?.profileChangeRequest().commitChanges()
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "signupToMain")
//                    self.present(vc!, animated: true, completion: nil)
                    self.performSegue(withIdentifier: "signupToMain", sender: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        // YOUR CODE HERE
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
