import ceylon.interop.java {
    javaClass
}

import org.ceylongradle.api {
    Project,
    Task,
    DefaultTask,
    Zip,
    SimpleTask
}
import org.gradle.api {
    GProject=Project,
    GTask=Task
}
import org.gradle.api.tasks.bundling {
    GZip=Zip
}
shared class ProjectInternal(shared GProject gproject) satisfies Project{
    shared actual Task task(String|Task t){
      
        Task task = switch(t) 
                    case(is String) SimpleTask(t)
                    case(is Task) t;
        assert(is Bridge<GTask> bridge = task.bridge);
        bridge.createAndAdd(this);
        return task;
    }
    
    
    void add(Task task){
       
    }
    

    
    suppressWarnings("expressionTypeNothing")
    shared GTask createAndAdd<GTaskType>(String name) given GTaskType satisfies GTask=> gproject.tasks.create<GTaskType>(name, javaClass<GTaskType>());
    
    
    
    //shared TaskType task<TaskType = Task>(String name, TaskAction<TaskType>? taskAction = null)
    //        given TaskType satisfies Task {
    //    value type = javaClass<TaskType>();
    //    return if (exists taskAction)
    //            then project.tasks.create<TaskType>(name, type, object satisfies Action<TaskType> {
    //            execute(TaskType t) => taskAction(t);
    //        })
    //            else project.tasks.create<TaskType>(name, type);
    //}
    
}