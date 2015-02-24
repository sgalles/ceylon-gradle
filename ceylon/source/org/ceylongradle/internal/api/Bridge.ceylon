import org.gradle.api {
    GTask=Task
}
shared abstract class Bridge<out GTaskType>() given GTaskType satisfies GTask{
    
    shared formal String name;
    
    shared void createAndAdd(ProjectInternal project)
        => project.createAndAdd<GTaskType>(name);
    
}