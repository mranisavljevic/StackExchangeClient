//
//  SwiftQuestion.swift
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/9/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

import Foundation

@objc class SwiftQuestion: NSObject {
    let questionId: Int
    let title: NSString
    let owner: User
    let creationDate: NSDate
    let lastActivityDate: NSDate
    let viewCount: Int
    let score: Int
    let answerCount: Int
    let acceptedAnswerId: Int
    let link: NSURL
    let isAnswered: Bool
    
    init(questionId: Int, title: NSString, owner: User, creationDate: NSDate, lastActivityDate: NSDate, viewCount: Int, score: Int, answerCount: Int, acceptedAnswerId: Int, link: NSURL, isAnswered: Bool) {
        self.questionId = questionId
        self.title = title
        self.owner = owner
        self.creationDate = creationDate
        self.lastActivityDate = lastActivityDate
        self.viewCount = viewCount
        self.score = score
        self.answerCount = answerCount
        self.acceptedAnswerId = acceptedAnswerId
        self.link = link
        self.isAnswered = isAnswered
    }
}