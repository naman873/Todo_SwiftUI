//
//  LocalStorage.swift
//  TodoApp
//
//  Created by Naman Dhiman on 23/12/24.
//

import Foundation
import SwiftUI

class LocalStorage: ObservableObject{
    
    @Published var taskList:[DataModel]=[]{
        didSet{
            saveTask();
        }
    }
    @Published var editingData:DataModel=DataModel(title: "", description: "");
    @Published var isEditing:Bool = false;

    
    private let  key = "taskList";
    
    init(){
        taskList = allTasks()
    }
    
    func saveTask(){
        if let encoded = try? JSONEncoder().encode(taskList){
            UserDefaults.standard.set(encoded, forKey:key);
        }
    }
    
    func addTask(_ title:String,_ description:String){
        let data = DataModel(title: title, description: description);
        taskList.append(data);
    }
    
    func allTasks()->[DataModel]{
        if let data = UserDefaults.standard.data(forKey: key),
            let listData = try? JSONDecoder().decode([DataModel].self, from: data){
                return listData;
            }
        return [];
    }
    
    func removeTask(data:DataModel){
        if let removingId = taskList.firstIndex(of: data){
            taskList.remove(at: removingId)
        }
    }
    
    func editData(data:DataModel,newTitle:String,newDescription:String){
        if let editingId = taskList.firstIndex(of: data){
            taskList[editingId].title=newTitle;
            taskList[editingId].description=newDescription;
        }
    }
    
}

struct DataModel: Codable,Hashable,Identifiable{
    var id = UUID()
    var title:String
    var description: String
}
