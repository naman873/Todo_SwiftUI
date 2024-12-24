//
//  ContentView.swift
//  TodoApp
//
//  Created by Naman Dhiman on 22/12/24.
//

import SwiftUI

struct HomePage: View {
        
    @EnvironmentObject var localStorage:LocalStorage;
    
    @State private var paths:[String] = [];
    
    var body: some View {
        NavigationStack(path: $paths){
            ZStack{
                VStack{
                if(localStorage.taskList.isEmpty){
                    VStack{
                        Text("Todo List")
                        Spacer()
                        Text("All Task Finished")
                        Spacer()
                    }
                }
                else{
                    List{
                        Section(header: Text("Todo List").font(.system(size: 25))){ForEach(localStorage.taskList,id:\.self){ item in
                            VStack(alignment:.leading){
                                Text(item.title).listRowBackground(Color.white).font(.system(size: 20)).padding(2)
                                Text(item.description).font(.system(size: 16)).padding(2)
                            }.swipeActions{
                                Button("Delete"){
                                    localStorage.removeTask(data: item)
                                    print("Delete");
                                }.tint(.red)
                                Button("Edit"){
                                    localStorage.isEditing=true;
                                    localStorage.editingData = item;
                                    paths.append("AddTask")
                                    print("Edit");
                                }.tint(.blue)
                            }
                        }
                        }
                    }.listStyle(InsetGroupedListStyle())
                }
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action:{
                        localStorage.isEditing=false;
                        paths.append("AddTask");
                    }){
                        Image(systemName: "plus").resizable().frame(width: 30,height: 30).padding().background(
                            LinearGradient(colors: [Color.blue,Color.black], startPoint: .topLeading, endPoint: .topTrailing)
                        ).foregroundStyle(Color.white).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).shadow(color:.black.opacity(0.3),radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,x: 2,y:2)
                    }.padding(16)
                }
            }
///This navigation destination works at the end of child inside navigiaton stack
        }.navigationDestination(for: String.self){ value in
           
            if value=="AddTask"{
                AddTask()
            }
           
        }
        }
    }
}

#Preview {
    HomePage()
}
