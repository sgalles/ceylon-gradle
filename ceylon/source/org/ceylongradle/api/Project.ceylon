import org.ceylongradle {
    AbstractScript
}
import org.ceylongradle.internal.api {
    ProjectInternal
}
import org.gradle.api {
    GTask=Task,
    GAction=Action
}
import org.gradle.api.tasks.bundling {
    GZip=Zip
}
import ceylon.interop.java {

    javaString
}


shared interface Project {
    
    shared formal Task task(String|Task task);
    
    void addRegistrationInternal<GTaskType>(Task task, String  name, void configure(GTaskType gtask)) 
            given GTaskType satisfies GTask{
        projectInternal(this).addRegistration<GTaskType>(task, name, configure);
    }
    
    suppressWarnings("expressionTypeNothing")
    GTaskType matchingGTask<GTaskType>(Task task)  given GTaskType satisfies GTask =>
        if(is GTaskType gt = projectInternal(this).gproject.tasks.getByName(task.name)) 
            then gt else nothing;
        
    
    
    
    shared class SimpleTask(String name) extends DefaultTask(name) {
        
        // register
        late Task self;
        addRegistrationInternal<GTask>(self = this, name, noop);
    }
    
    shared class Zip extends DefaultTask {
       
        late Task self;
        shared new Zip(String name, String baseName, String? from = null) extends DefaultTask(name){
            void configure(GZip gtask){
                gtask.baseName = baseName;
                if(exists from) {
                    gtask.from(javaString(from));
                }
            }
            addRegistrationInternal<GZip>(self = this, name, configure);
        }
       
        GZip gtask => matchingGTask<GZip>(this);
       
        shared String baseName => gtask.baseName;
        assign baseName {  gtask.baseName = baseName;}
       
    }
    
    shared abstract class DefaultTask(name) satisfies Task {
        
        shared actual String name;
        
        shared actual DefaultTask doLast(Action<Task> action) {
            projectInternal(outer).gproject.tasks.getByName(name).doLast(object satisfies GAction<GTask> {
                execute(GTask t) => action(outer);
             });
            return this;
        }
    }
}

suppressWarnings("expressionTypeNothing")
ProjectInternal projectInternal(Project project) 
        => switch(project)
           case(is ProjectInternal) project
           case(is AbstractScript)  (if(is ProjectInternal prjInternal = project.project) then prjInternal else nothing)
           else nothing; 
        
