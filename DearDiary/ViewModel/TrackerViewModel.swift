//
//  TaskViweModel.swift
//  DearDiary
//
//  Created by eman alejilah on 15/06/1444 AH.
//

import CoreData
import SwiftUI



class TrackerViewModel : ObservableObject {

    @Published var openEditTracker: Bool = false
    @Published var TrackerTitle: String = ""
    @Published var TrackerDeadline: Date = Date()
      @Published var TrackerType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    @Published var editTracker : Mood?
    
    @Published var toggleCardMenu = false
    
    
    func addMood(context:NSManagedObjectContext) -> Bool{
        
        var mood:Mood!
        //        if let editTask = editTask {
        //            task = editTask
        //        } else {
        //            task = Task(context: context)
        //        }
        if editTracker != nil && openEditTracker == true {
            mood = editTracker
        } else {
            mood = Mood (context: context)
        }
        
        mood.title = TrackerTitle
//        task.color = taskColor
       
        mood.deadline = TrackerDeadline
              mood.type = TrackerType
       
        
        if let _ = try? context.save(){
            return true
        }
        return false
    }
    
    func resetData(){
       
//        taskColor = "Purple"
        TrackerTitle = ""
        TrackerDeadline = Date()
        openEditTracker = false
    }
    
    func setupTracker(){
        
        
        if let editTracker = editTracker {
         

            TrackerTitle = editTracker.title ?? ""
            TrackerDeadline = editTracker.deadline ?? Date()
        }
        
        
        
    }

    
    }

