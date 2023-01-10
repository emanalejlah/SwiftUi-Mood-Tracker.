//
//  AddNewTask.swift
//  DearDiary
//
//  Created by eman alejilah on 15/06/1444 AH.
//
import SwiftUI

struct AddNewTracker: View {
    @EnvironmentObject var TrackerModel:TrackerViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.self) var env
    
    var body: some View {
        VStack(alignment:.center, spacing: 5.0) {
            Text(TrackerModel.openEditTracker ? "Edit" : "How are you feeling today?")
                .accessibilityLabel(Text("How are you feeling today?"))
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
            VStack(alignment: .leading,spacing: 5.0){
                Text(TrackerModel.TrackerDeadline.formatted(date:.abbreviated,time: .omitted)
                     + ", " + TrackerModel.TrackerDeadline.formatted(date: .omitted, time: .shortened))
                .frame(maxWidth:.infinity)
                .font(.callout.weight(.semibold))
                .padding()
                .overlay{
                    if TrackerModel.showDatePicker {
                        
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .onTapGesture{
                                TrackerModel.showDatePicker = false
                            }
                        
                        DatePicker.init("",selection: $TrackerModel.TrackerDeadline,in:Date.distantPast...Date.distantFuture)
                            .labelsHidden()
                    }
                }
            }.frame(maxWidth:.infinity,alignment: .leading)
                .overlay(alignment: .bottomTrailing){
                    
                    
                    Button{
                        TrackerModel.showDatePicker.toggle()
                        print(TrackerModel.showDatePicker)
                        
                        print("calender pickk")
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                }
            
            
            
       
            ZStack(){
                

                }

                
            let TrackerTypes : [String] = [NSLocalizedString("Happy", comment: ""),
                 NSLocalizedString("Sad", comment: ""),
                 NSLocalizedString("Angry", comment: ""),
                 NSLocalizedString("Neutral", comment: "")
            ]
            VStack(spacing: 2.0){
                    Text("Select your mood")
                    .accessibilityLabel(Text("Select your mood"))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(30)
                HStack(spacing: 44.0){
                        Group{
                            Image("Happy")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50 , height: 50)

                            Image("Sad")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50 , height: 50)

                            Image("Angry")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50 , height: 50)

                            Image("Neutral")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50 , height: 50)
                      
                            
                        }
                    }
                    HStack(spacing:12){
                        ForEach(TrackerTypes, id: \.self){
                            type in
                            Text(type)
                                .accessibility(label:(Text(type)))
                                .lineLimit(2)
                                .font(.callout)
                                .padding(.vertical,10)
                                .frame(maxWidth:.infinity)
                                .foregroundColor(TrackerModel.TrackerType == type ? .white : .black)
                                .background{
                                    
                                    if TrackerModel.TrackerType == type {
                                        Capsule().fill(Color("Color 333"))
                                    } else {
                                        Capsule().strokeBorder(.gray)
                                    }
                                    
                                }.onTapGesture {
                                    withAnimation{TrackerModel.TrackerType = type}
                                }
                        }
                       
                        

                    }            .frame(maxWidth:.infinity,alignment: .leading)

                   
                        .padding(.vertical,10)


                }.padding()
                    .frame(maxWidth:.infinity,alignment: .leading)
            
            VStack(alignment: .leading,spacing: 12){
                Text("What are the reasons behind this feeling?")
                    .accessibilityLabel(Text("What are the reasons behind this feeling?"))
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.black)
                TextField("Express yourself",text: $TrackerModel.TrackerTitle)
                
                    .padding()
                    .frame(width: 345.0, height: 155.0)
                
               
                
                
            }
            
            Button{
                
                
                if TrackerModel.addMood(context: env.managedObjectContext){
                    
                    env.dismiss()
                }
                
            }label: {
                Text("Save")
                    .accessibility(label:(Text("Save")))
                
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 21, design: .rounded))
//                        .frame(maxWidth:.infinity)
                    .frame(width: 279.0, height: 77.0)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("blue"))
                    }
            }.padding(.vertical,50.0)
            
            
            
            
            

            }
            
        }
        

    }
        
    
struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTracker()
            .environmentObject(TrackerViewModel())
    }
}
