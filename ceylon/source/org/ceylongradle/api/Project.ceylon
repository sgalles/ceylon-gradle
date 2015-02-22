
shared interface Project {
    
    //shared formal TaskType task<TaskType>(String name, TaskConfigurator<TaskType>? taskAction = null);
    
     shared formal Task task(String name);  
    
     shared formal Task taskAdd(Task task);        
    
   
   
}

shared class DefaultTask(name) satisfies Task{
    
    shared actual String name;
    
    shared default actual DefaultTask doLast(TaskAction<Task> action) => nothing;
    
    
    
}

shared class Zip(name) extends DefaultTask(name) {
    String name;
    shared variable String baseName = "myzip";
    shared actual Zip doLast(TaskAction<Task> action) => nothing;
}