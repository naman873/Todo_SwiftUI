//
//  AddItem.swift
//  TodoApp
//
//  Created by Naman Dhiman on 22/12/24.
//

import Foundation
import SwiftUI
import SwiftUISnackbar

struct AddTask:View {
    
    @EnvironmentObject var localStorage: LocalStorage;
    @Environment(\.dismiss) var dismiss;
    @State private var titleController:String="";
    @State private var descriptionController:String="";
    @State private var isShow=false;
    @State private var isEdit=false;
    

    var body: some View {
        VStack(alignment:.leading){
            Spacer().frame(height: 100)
            Text("Title").font(.headline)
            TextField("Title", text: $titleController).textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer().frame(height: 40)
            Text("Description")
            TextField("Description",text:$descriptionController).textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer().frame(height: 60)
            HStack{
                Spacer()
                Button(action: {
                    if(isEdit==false){
                        if(titleController.isEmpty || descriptionController.isEmpty){
                            isShow = true;
                        }
                        else{
                            localStorage.addTask(titleController,descriptionController);
                            dismiss();
                        }
                    }
                    else{
                        if(titleController.isEmpty || descriptionController.isEmpty){
                            isShow = true;
                        }
                        else{
                            localStorage.editData(data: localStorage.editingData,newTitle:titleController,newDescription: descriptionController );
                            dismiss();
                        }
                    }
                }){
                    Text(isEdit ? "Update Task" : "Add Task").frame(width: 100).padding().background(.green.opacity(0.7)).foregroundStyle(Color.white).clipShape(.capsule)
                }
                Spacer()
            }
            Spacer()
        }.padding().navigationTitle("Add Task")
            .snackbar(isShowing: $isShow, title: "Error", text: "Please Enter Title and Description", style: .custom(.red)).onAppear{
                
                print("onAppear")
                
                if(localStorage.isEditing){
                    titleController = localStorage.editingData.title;
                    descriptionController = localStorage.editingData.description;
                    isEdit=true;
                }
            }
    }
}


#Preview {
    AddTask()
}
