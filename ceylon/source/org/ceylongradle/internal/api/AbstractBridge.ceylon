import org.gradle.api {
    GTask=Task
}
shared abstract class AbstractBridge<out GTaskType>() given GTaskType satisfies GTask{
    
    shared formal String name;
    
    shared void createAndAdd(ProjectInternal project){
       //gtask = project.createAndAdd<GTaskType>(name);
    }
    
    shared late GTaskType gtask;
    
}