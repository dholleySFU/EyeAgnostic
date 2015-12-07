//
//  SurveyTask.swift
//  RK
//
//  Created by Tony Lu on 2015-11-23.
//  Copyright © 2015 Tony Lu. All rights reserved.
//  Group 01

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //TODO: add instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Introduction"
    instructionStep.text = "10 Questions that you can just answer or skip! (Although we do hope you will answer them.)"
    steps += [instructionStep]
    
    //TODO: add questions
    
    //question 1
    let ageAnswerFormat = ORKTextAnswerFormat(maximumLength: 2)
    ageAnswerFormat.multipleLines = false
    let ageQuestionStepTitle = "What is the child's age?"
    let ageQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: ageQuestionStepTitle, answer: ageAnswerFormat)
    steps += [ageQuestionStep]
    
    //question 2
    let geneticQuestionStepTitle = "Has there been any other incidences of this disease in other family members?"
    let textChoices = [
        ORKTextChoice(text: "Yes", value: 0),
        ORKTextChoice(text: "No", value: 1),
    ]
    let geneticAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let geneticQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: geneticQuestionStepTitle, answer: geneticAnswerFormat)
    steps += [geneticQuestionStep]
    
    //question 3
    let questQuestionStepTitle = "Is the tumor in one or both eyes?"
    let textChoices2 = [
        ORKTextChoice(text: "Right Eye", value: 0),
        ORKTextChoice(text: "Left Eye", value: 1),
        ORKTextChoice(text: "Both Eyes", value: 2),
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices2)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep2", title: questQuestionStepTitle, answer: questAnswerFormat)
    steps += [questQuestionStep]
    
    //question 4
    let questQuestionStepTitle3 = "Do you know anything about genetic counselling?"
    let textChoices3 = [
        ORKTextChoice(text: "Yes", value: 0),
        ORKTextChoice(text: "No", value: 1),
    ]
    let questAnswerFormat3: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices3)
    let questQuestionStep3 = ORKQuestionStep(identifier: "TextChoiceQuestionStep3", title: questQuestionStepTitle3, answer: questAnswerFormat3)
    steps += [questQuestionStep3]
    
    //question 5
    let nameAnswerFormat2 = ORKTextAnswerFormat(maximumLength: 300)
    let nameQuestionStepTitle2 = "How did you first realize your child was sick?"
    let nameQuestionStep2 = ORKQuestionStep(identifier: "QuestionStep2", title: nameQuestionStepTitle2, answer: nameAnswerFormat2)
    steps += [nameQuestionStep2]
    
    //question 6
    let nameAnswerFormat3 = ORKTextAnswerFormat(maximumLength: 300)
    let nameQuestionStepTitle3 = "What treatment is the child taking?"
    let nameQuestionStep3 = ORKQuestionStep(identifier: "QuestionStep3", title: nameQuestionStepTitle3, answer: nameAnswerFormat3)
    steps += [nameQuestionStep3]
    
    //question 7
    let nameAnswerFormat4 = ORKTextAnswerFormat(maximumLength: 100)
    let nameQuestionStepTitle4 = "How long has the treatment been ongoing?"
    let nameQuestionStep4 = ORKQuestionStep(identifier: "QuestionStep4", title: nameQuestionStepTitle4, answer: nameAnswerFormat4)
    steps += [nameQuestionStep4]
    
    //question 8
    let nameAnswerFormat5 = ORKTextAnswerFormat(maximumLength: 300)
    let nameQuestionStepTitle5 = "What major questions do you have about the process and about the treatment itself?"
    let nameQuestionStep5 = ORKQuestionStep(identifier: "QuestionStep5", title: nameQuestionStepTitle5, answer: nameAnswerFormat5)
    steps += [nameQuestionStep5]
    
    //question 9
    let nameAnswerFormat6 = ORKTextAnswerFormat(maximumLength: 300)
    let nameQuestionStepTitle6 = "Are there any side effects of the treatment? State any if there is."
    let nameQuestionStep6 = ORKQuestionStep(identifier: "QuestionStep6", title: nameQuestionStepTitle6, answer: nameAnswerFormat6)
    steps += [nameQuestionStep6]
    
    //question 10
    let nameAnswerFormat7 = ORKTextAnswerFormat(maximumLength: 300)
    let nameQuestionStepTitle7 = "Let's do a switcheroo. Are there any questions you would like to ask us??"
    let nameQuestionStep7 = ORKQuestionStep(identifier: "QuestionStep7", title: nameQuestionStepTitle7, answer: nameAnswerFormat7)
    steps += [nameQuestionStep7]
    
    
    
    
    //TODO: add summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "All done!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]
    
    Globals.retSource = "Survey"
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}