

shared alias Action<TaskType> => Anything(TaskType);

shared interface Task satisfies Identifiable{
    
    shared formal String name;
    
    shared formal Task doLast(Action<Task> action);
  
    
}



