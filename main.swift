import Foundation

class ToDo_list{
    var items = [ToDo_item]()
    
    func append(item: ToDo_item){
       self.items.append(item)
    }
    
    func delete(title: String){
        if let index = self.items.firstIndex(where: {$0.title == title}) {
            self.items.remove(at: index)
        }
    }
   
   func print_list(){
       for index in self.items {
            index.print_item(flag: true)
        }
   }
   func sort_time(order: String){
       var sortedItems = [ToDo_item]()
       if (order == "asc"){
            sortedItems = items.sorted {
                $0.time < $1.time
            }
        }else{
            sortedItems = items.sorted {
                $0.time > $1.time
            }
        }
        self.items = sortedItems
   }
   func sort_title(order: String) {
       var sortedItems = [ToDo_item]()
       if (order == "asc"){
            sortedItems = items.sorted {
                $0.title < $1.title
            }
        }else{
            sortedItems = items.sorted {
                $0.title > $1.title
            }
        }
        self.items = sortedItems
   }
   func sort_priority(order: String){
       var sortedItems = [ToDo_item]()
       if (order == "asc"){
                sortedItems = items.sorted {
                $0.priority < $1.priority
            }
        }else{
                sortedItems = items.sorted {
                $0.priority > $1.priority
            }
        }
        self.items = sortedItems
   }
   
}

class ToDo_group_list{
    var items = [ToDo_group]()
    
    func append(group: ToDo_group){
       self.items.append(group)
   }
    
   func print_group_list(){
       for index in self.items{
           index.print_list()
       }
   }
   func get_items()-> [ToDo_group]{
       return items
   }
   func sort_time(order: String) {
       var sortedItems = [ToDo_group]()
       for index in items{
          index.sort_time(order: order)
       }
        if (order == "asc"){
             sortedItems = items.sorted {
                $0.time < $1.time
            }
        }else{
            sortedItems = items.sorted {
                $0.time > $1.time
            }
        }
        self.items = sortedItems

   }
   func sort_title(order: String){
       var sortedItems = [ToDo_group]()
       for index in items{
           index.sort_title(order: order)
       }
        if (order == "asc"){
            sortedItems = items.sorted {
                $0.name < $1.name
            }
        }else{
            sortedItems = items.sorted {
                $0.name > $1.name
            }
        }
        self.items = sortedItems
   }
   func sort_priority(order: String) {
       var sortedItems = [ToDo_group]()
       for index in items{
           index.sort_priority(order: order)
       }
        if (order == "asc"){
             sortedItems = items.sorted {
                $0.highestPriority < $1.highestPriority
            }
        }else{
             sortedItems = items.sorted {
                $0.highestPriority > $1.highestPriority
            }
        }
        self.items = sortedItems
   }
}

class ToDo_group {
   var someItems = [ToDo_item]()
   var name: String
   var time: Date
   var highestPriority: Int
   
   init(name: String, time: Date){
       self.name = name
       self.time = time
       self.highestPriority = 0
   }

   func append(item: ToDo_item){
       self.someItems.append(item)
       if (item.priority > self.highestPriority){
           self.highestPriority = item.priority
       }
   }
   
   func delete(title: String){
        if let index = self.someItems.firstIndex(where: {$0.title == title}) {
            self.someItems.remove(at: index)
        }
    }
   
   func print_list(){
       print("\(self.name) [\(self.time)]")
       for index in self.someItems {
            index.print_item(flag: false)
        }
   }
   func sort_title(order: String) {
       var sortedItems = [ToDo_item]()
       if (order == "asc"){
            sortedItems = someItems.sorted {
                $0.title < $1.title
            }
        }else{
            sortedItems = someItems.sorted {
                $0.title > $1.title
            }
        }
        self.someItems = sortedItems
   }
   func sort_time(order: String) {
       var sortedItems = [ToDo_item]()
        if (order == "asc"){
            sortedItems = someItems.sorted {
                $0.time < $1.time
            }
        }else{
            sortedItems = someItems.sorted {
                $0.time > $1.time
            }
        }
        self.someItems = sortedItems
   }
   func sort_priority(order: String) {
        var sortedItems = [ToDo_item]()
        if (order == "asc"){
            sortedItems = someItems.sorted {
                $0.priority < $1.priority
            }
        }else{
            sortedItems = someItems.sorted {
                $0.priority > $1.priority
            }
        }
        self.someItems = sortedItems
   }
}

class ToDo_item {
   var title: String
   var content: String
   var priority: Int
   var time: Date
   
   init(title: String, content: String, priority: Int, time: Date) {
      self.title = title
      self.content = content
      self.priority = priority
      self.time = time
   }
   
   func print_item(flag: Bool) {
        if (flag){
            print("\(self.title): \n \t\(self.content) [\(self.time)]")
        }
        else{
            print("\t\(self.title): \n\t \t \(self.content) [\(self.time)]")
        }
    }
    
    func edit_title(title: String){
        self.title = title
    }
    func edit_content(content: String){
        self.content = content
    }
    func edit_priority(priority: Int){
        self.priority = priority
    }
}

func showAll(itemList: ToDo_list, groupList: ToDo_group_list){
    print("Items: \n")
    itemList.print_list()
    print("Groups: \n")
    groupList.print_group_list()
}

func makeContent(commandArr: [String], edit: Bool)->String{
    let length = commandArr.count
    var result = ""
    var end: Int
    if edit{
        end=length
    }
    else{
        end=length-1
    }
    for i in 2..<end{
        result = result + commandArr[i] + " "
    }
    
    return result
}

let itemList = ToDo_list()
let groupList = ToDo_group_list()
print(">>>")
while let cmd = readLine(){
    let cmdArr = cmd.components(separatedBy: " ")
    switch cmdArr[0] {
    
        case "ShowAll":
            showAll(itemList: itemList, groupList: groupList)
        case "ShowGroup":
            let arr = groupList.items
            if let group = arr.first(where: {$0.name == cmdArr[1]}) {
                group.print_list()
            }
        
        case "AddItem":
            print("\tCreating item...")
            let item = ToDo_item(title: cmdArr[1], content: makeContent(commandArr: cmdArr, edit: false), priority: Int(cmdArr[cmdArr.count-1])!, time: Date())
            itemList.append(item: item)
            print("\tItem created.")
            
        case "EditItemTitle":
            print("\tEditing item's title...")
            let arr_item = itemList.items
            if let item = arr_item.first(where: {$0.title == cmdArr[1]}) {
                item.edit_title(title: cmdArr[2])
            }
            print("\tItem Edited.")
        
        case "EditItemContent":
            print("\tEditing item's content...")
            let arr_item = itemList.items
            if let item = arr_item.first(where: {$0.title == cmdArr[1]}) {
                item.edit_content(content: makeContent(commandArr: cmdArr, edit: true))
            }
            print("\tItem Edited.")
            
        case "EditItemPriority":
            print("\tEditing item's priority...")
            let arr_item = itemList.items
            if let item = arr_item.first(where: {$0.title == cmdArr[1]}) {
                item.edit_priority(priority: Int(cmdArr[2])!)
            }
            print("\tItem Edited.")
            
        case "AddGroup":
            print("\tcreating group...")
            var flag = 0
            for index in groupList.get_items(){
                if(index.name == cmdArr[1]){
                    flag = 1
                    break
                }
            }
            if(flag == 1){
                print("\t Group with this name already exists.")
            }else{
                let group = ToDo_group(name: cmdArr[1], time: Date())
                groupList.append(group: group)
                print("\tGroup created.")}
        
        case "AddToGroup":
            print("\tAdding to group...")
            let arr_group = groupList.items
            let arr_item = itemList.items
            if let group = arr_group.first(where: {$0.name == cmdArr[1]}), let item = arr_item.first(where: {$0.title == cmdArr[2]}) {
                group.append(item: item)
            }
            print("\tAdded to group.")
        
        case "DeleteItem":
            itemList.delete(title: cmdArr[1])
            for group in groupList.get_items(){
                for i in group.someItems{
                    if (i.title == cmdArr[1]){
                        group.delete(title: cmdArr[1])
                    }
                }
            }
            print("\tSelected item deleted.")
        
        case "Sort":
            if(cmdArr[1] == "time"){
                
                    itemList.sort_time(order: cmdArr[2])
                    groupList.sort_time(order: cmdArr[2])
                    showAll(itemList: itemList, groupList: groupList)

            } else if(cmdArr[1] ==  "title"){
                   
                    itemList.sort_title(order: cmdArr[2])
                    groupList.sort_title(order: cmdArr[2])
                    showAll(itemList: itemList, groupList: groupList)
            } else if(cmdArr[1] == "priority"){
                    itemList.sort_priority(order: cmdArr[2])
                    groupList.sort_priority(order: cmdArr[2])
                    showAll(itemList: itemList, groupList: groupList)
            }

            
        case "End":
            print("\tToDo closed.")
            
        default:
            print("\tCommand not identified!")
    }
    print(">>>")
    if (cmd == "End"){
        break
    }
}



