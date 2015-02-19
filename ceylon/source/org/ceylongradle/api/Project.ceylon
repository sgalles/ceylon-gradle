shared interface Project {
    
    shared formal TaskType task<TaskType>(String name, TaskConfigurator<TaskType>? taskAction = null);  
            
   
}