shared alias TaskConfigurator<TaskType> => Anything(TaskType);

shared alias TaskAction<TaskType> => Anything(TaskType);

shared interface Task<Self> of Self
    given Self satisfies Task<Self>{
    
    shared formal Self doLast(TaskAction<Self> action);
    
}

shared interface SimpleTask satisfies Task<SimpleTask>{
    
}

shared interface Zip satisfies Task<Zip>{
    shared formal variable String baseName;
}