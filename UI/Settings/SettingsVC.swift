//
//  SettingsVC.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-31.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var settingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.delegate = self
         self.settingsTableView.dataSource = self
  }

    func deleteUserFromUserDefaults(){
        let def = UserDefaults.standard
        def.removeObject(forKey: "email")
        def.removeObject(forKey: "password")
      // performSegue(withIdentifier: "signoutSegue", sender: nil)
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "loginVCID") as! LoginController
//         appdeleg.window? = UIWindow(frame: UIScreen.main.bounds)
//         appdeleg.window?.rootViewController = initialViewController
//         appdeleg.window?.makeKeyAndVisible()
        self.present(initialViewController , animated: true, completion: nil)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsItems", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         deleteUserFromUserDefaults()
    }
}
