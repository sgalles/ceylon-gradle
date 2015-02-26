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


shared interface Project {
    
    shared formal Task task(String|Task task);
    
    void addRegistrationInternal<GTaskType>(Task task, String  name) 
            given GTaskType satisfies GTask{
        projectInternal(this).addRegistration<GTaskType>(task, name);
    }
    
    shared class SimpleTask(String name) extends DefaultTask(name) {
        
        // register
        late Task self;
        addRegistrationInternal<GTask>(self = this, name);
    }
    
    shared class Zip(name, baseName) extends DefaultTask(name) {
        String name;
        shared String baseName;
        
        //register
        late Task self;
        addRegistrationInternal<GZip>(self = this, name);
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
        
