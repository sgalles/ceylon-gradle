shared alias TaskConfigurator<TaskType> => Anything(TaskType);

shared alias TaskAction<TaskType> => Anything(TaskType);

shared interface Task {
    
    shared formal String name;
    
    shared formal Task doLast(TaskAction<Task> action);
    
}



