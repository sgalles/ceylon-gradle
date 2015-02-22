import ceylon.interop.java {
    javaClass
}

import java.lang {
    Class
}

import org.ceylongradle.api {
    Project,
    Task,
    TaskAction,
    DefaultTask,
    Zip
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
      
        value [Task task,String name] = switch(t) 
                    case(is String) [DefaultTask(t),t]
                    case(is Task) [t, t.name];
        
        value gtask = createAndAdd(name, task);
        return task;
    }
    
    
    void add(Task task){
       
    }
    

    
    GTask createAndAdd(String name, Task task) {
        
        GTaskType gcreateAndAdd<GTaskType>() 
                given GTaskType satisfies GTask
                    => gproject.tasks.create<GTaskType>(name, javaClass<GTaskType>());
    
         return if(is Zip task) then gcreateAndAdd<GZip>() 
                else if(is DefaultTask task) then gcreateAndAdd<GTask>()
                else nothing;
        
    }
    
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