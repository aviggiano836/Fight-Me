//
//  AchievementHandler.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class AchievementHandler: NSObject {
    
    var achievements: [Achievement]
    var currentAchievements: [Achievement]
    
    init(achievements: [Achievement],currentAchievements: [Achievement]){
        self.achievements = achievements
        self.currentAchievements = currentAchievements
    }
    
    

}
