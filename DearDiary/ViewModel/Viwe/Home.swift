//
//  Home.swift
//  DearDiary
//
//  Created by eman alejilah on 15/06/1444 AH.
//

import SwiftUI

struct Home: View {
   @StateObject var TrackerModel : TrackerViewModel = .init()
    
    @State var isShowingSheet = false
    
    
    
    @Environment(\.self) var env
    
    @FetchRequest(entity: Mood.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Mood.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var moods: FetchedResults<Mood>
    
    var body: some View {
        VStack{
            ScrollView {
                VStack(alignment:.center,spacing: 8) {
                    
 
                    Button {
                        
                        TrackerModel.resetData()
                        
                        isShowingSheet = true
                        
                    } label: {
                        ZStack{
                            Image("bg").resizable().containerShape(RoundedRectangle(cornerRadius: 8)).frame(width: 334, height: 124)
                            Text("How are you today?").fontWeight(.bold).foregroundColor(.white).font(.system(size: 21, design: .rounded))
                        }
                    }.sheet(isPresented: $isShowingSheet) {
                        
                        AddNewTracker()
                            .environmentObject(TrackerModel)
                    }.onAppear{
                        
                    }
                    
                    
                    TrackerView()
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
    }
    
    private func deleteItems2(_ item: Mood) {
        if let ndx = moods.firstIndex(of: item) {
            env.managedObjectContext.delete(moods[ndx])
            do {
                try env.managedObjectContext.save()
            } catch {
   
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
    @ViewBuilder
    func TrackerView()->some View{
        
        LazyVStack(spacing:20){
            ForEach(moods){ mood in
                TrackerRowView(mood:mood)
                   

            }
        }
        
    }
    
    
    
    @ViewBuilder
    func TrackerRowView(mood:Mood)->some View{
        ZStack{
            
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color("Color 11"))
                .frame(width: 334
                       ,height: 150)
               
            
            VStack(alignment:.leading, spacing: 20){
                HStack{
                    Text(mood.type ?? "")
                        .accessibility(label:(Text(mood.type ?? "")))

                        .font(.callout)

                        .background{
                            Capsule().fill(.white.opacity(0.3))
                        }
                    Spacer()
                    
                    Menu {
                        Button("Edit", action: {
                            TrackerModel.openEditTracker = true
                            if TrackerModel.openEditTracker{
                                TrackerModel.editTracker = mood
                                
                                
                                TrackerModel.setupTask()
                                isShowingSheet = true
                            }
                        }).accessibility(label:(Text("Open edit Menu")))
                        Button("Delete", action: {deleteItems2(mood)})
                        Button("Cancel", action: {})
                    } label: {
                        Image(systemName: "ellipsis.circle")
                           
                            .font(.system(size: 26.0, weight: .bold))
                            .foregroundColor(.black)
                           
                        
                        
                    }.accessibility(label:(Text("Open Edit Menu")))
                }
                Text(mood.title ?? "")
                    .accessibility(label:(Text(mood.title ?? "")))
                    .font(.title2.bold())
                    .foregroundColor(.black)
                HStack(alignment:.bottom,spacing: 0){
                    VStack(alignment:.leading,spacing: 10){
                        Label{
                            Text((mood.deadline ?? Date()).formatted(date: .long, time:.omitted))
                        } icon: {
                            Image(systemName: "calendar")
                        }.accessibility(label:(Text("calendar")))
                            .accessibility(label: Text((mood.deadline ?? Date()).formatted(date: .long, time:.omitted)))
                        .font(.caption)
                        Label{
                            Text((mood.deadline ?? Date()).formatted(date: .omitted, time:.shortened))
                               
                        }
                    icon: {
                            Image(systemName: "clock")
                        }.font(.caption)
                            .accessibility(label:(Text("clock")))
                            .accessibility(label: Text((mood.deadline ?? Date()).formatted(date: .omitted, time:.shortened)))
                    }
                    
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                }
            }

                .frame(width: 300
                       ,height: 100)

            
            
           
        }
        
    }
    
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

