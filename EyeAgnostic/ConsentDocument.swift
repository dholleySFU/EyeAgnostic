//
//  ConsentDocument.swift
//  RK
//
//  Created by Tony Lu on 2015-11-23.
//  Copyright © 2015 Tony Lu. All rights reserved.
//  Group 01

import Foundation
import ResearchKit

public var ConsentDocument:ORKConsentDocument {
    
    let consentDocument=ORKConsentDocument()
    //var curBool: Bool = false
    consentDocument.title = "Consent"
    
    //Consent Sections
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .Privacy,
        .DataUse,
        .TimeCommitment,
        .StudySurvey,
        .StudyTasks,
        .Withdrawing
    ]
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        
        switch contentSectionType {
            
        case ORKConsentSectionType.Overview:
            let Overviews = ORKConsentSection(type: contentSectionType)
            Overviews.summary = "In this study..."
            Overviews.content = "You will be asked 10 easy question."
            return Overviews
            
        case ORKConsentSectionType.Privacy:
            let Privacies = ORKConsentSection(type: contentSectionType)
            Privacies.summary = "In this study..."
            Privacies.content = "Your answers will be private and shared as anonymous."
            return Privacies
            
        case ORKConsentSectionType.DataUse:
            let DataUses = ORKConsentSection(type: contentSectionType)
            DataUses.summary = "In this study..."
            DataUses.content = "Your answers will aid in scientific research and related studies on Retinoblastoma"
            return DataUses
            
        case ORKConsentSectionType.TimeCommitment:
            let TimeCommitments = ORKConsentSection(type: contentSectionType)
            TimeCommitments.summary = "In this study..."
            TimeCommitments.content = "This survey will take around 10 minutes. Fast right?"
            return TimeCommitments
            
        case ORKConsentSectionType.StudySurvey:
            let StudySurveys = ORKConsentSection(type: contentSectionType)
            StudySurveys.summary = "In this study..."
            StudySurveys.content = "You will be asked to input text field answers and multiple choice answers."
            return StudySurveys
            
        case ORKConsentSectionType.StudyTasks:
            let StudyTaskss = ORKConsentSection(type: contentSectionType)
            StudyTaskss.summary = "In this study..."
            StudyTaskss.content = "You will only need to complete it ONCE! Easy right?"
            return StudyTaskss
            
        case ORKConsentSectionType.Withdrawing:
            let Withdrawings = ORKConsentSection(type: contentSectionType)
            Withdrawings.summary = "In this study..."
            Withdrawings.content = "If you wish to withdraw halfway through, just hit the cancel button and nothing will be saved. Don't withdraw though. Please. You are more important than you think you are."
            return Withdrawings
            
        default:
            consentSection.summary = "If you see this message..."
            consentSection.content = "There's something wrong..."
            
        }
        
        return consentSection
    }
    
    
    consentDocument.sections = consentSections
    
    // Getting Signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    
    return consentDocument
}