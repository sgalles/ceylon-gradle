import org.ceylongradle.api {
    Project,
    TaskConfigurator,
    SimpleTask
}

shared abstract class AbstractScript(Project project) satisfies Project {
    
    shared formal void execute();
    
    shared actual TaskType task<TaskType=SimpleTask>(String name, 
        TaskConfigurator<TaskType>? taskAction)
            => project.task(name, taskAction);
    
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