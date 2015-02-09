import ceylon.interop.java {
    javaClass
}

import org.gradle.api {
    Project,
    Task,
    Action
}
shared abstract class AbstractScript(Project project) {
    
    shared alias TaskAction<TaskType> => Anything(TaskType);
    
    shared formal void execute();
    
    shared TaskType task<TaskType = Task>(String name, TaskAction<TaskType>? taskAction = null)
            given TaskType satisfies Task {
        value type = javaClass<TaskType>();
        return if (exists taskAction)
                then project.tasks.create<TaskType>(name, type, object satisfies Action<TaskType> {
                execute(TaskType t) => taskAction(t);
            })
                else project.tasks.create<TaskType>(name, type);
    }
}