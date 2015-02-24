import org.ceylongradle.internal.api {
    Bridge,
    ProjectInternal
}

import org.gradle.api {
    GProject=Project,
    GTask=Task
}

shared interface Project {
    
     shared formal Task task(String|Task task);  
   
   
}

shared abstract class DefaultTask(name) satisfies Task{
    
    shared actual String name;
    
    shared default actual DefaultTask doLast(TaskAction<Task> action) => nothing;
    
    
    
}


shared class SimpleTask(String name) extends DefaultTask(name){
    
    object bridgeInternal satisfies Bridge{
        
        createAndAdd(ProjectInternal project) 
                => project.createAndAdd<GTask>(name);
        
    }
    shared actual Object bridge => bridgeInternal;
    
}
   
    
    
    


shared class Zip(name) extends DefaultTask(name) {
    String name;
    shared variable String baseName = "myzip";
    shared actual Zip doLast(TaskAction<Task> action) => nothing;
    
    object bridgeInternal satisfies Bridge{
        createAndAdd(ProjectInternal project) 
                => project.createAndAdd<GTask>(name);
    }
    shared actual Object bridge => bridgeInternal;
}