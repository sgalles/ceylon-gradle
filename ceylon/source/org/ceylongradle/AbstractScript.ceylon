import org.ceylongradle.api {
    Project,
    Task,
    TaskAction,
    DefaultTask
}
import org.ceylongradle.internal.api {
    ProjectInternal
}
import org.gradle.api {
    GProject=Project
}

shared abstract class AbstractScript(Object gProject) satisfies Project {
    assert(is GProject gProject);
    shared Project project = ProjectInternal(gProject);
    shared formal void execute();
    
    task(String name) => project.task(name);
    
    taskAdd(Task t) => project.taskAdd(t);
    
    //shared actual TaskType task<TaskType=DefaultTask>(String name, 
    //    TaskConfigurator<TaskType>? taskAction)
    //        => project.task(name, taskAction);
    //

    
    /*shared object task2{
        
    }*/
    //
    //shared alias TaskAction<TaskType> => Anything(TaskType);
    //
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