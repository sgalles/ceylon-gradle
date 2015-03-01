import ceylon.collection {
    IdentityMap
}
import ceylon.interop.java {
    javaClass
}

import org.ceylongradle.api {
    Project,
    Task
}
import org.gradle.api {
    GProject=Project,
    GTask=Task
}
shared class ProjectInternal(shared GProject gproject) satisfies Project{
   
    
    shared actual late TaskHolder task;
    
    
    shared void addRegistration<GTaskType>(String  name, void configure(GTaskType gtask))
            given GTaskType satisfies GTask{
        configure(createAndAdd<GTaskType>(name));
    }
    
    GTaskType createAndAdd<GTaskType>(String name) 
            given GTaskType satisfies GTask
            => gproject.tasks.create<GTaskType>(name, javaClass<GTaskType>());
    
    
    
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