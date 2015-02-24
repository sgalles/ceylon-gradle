import org.ceylongradle.internal.api {
    Bridge,
    ProjectInternal
}
import org.gradle.api {
    GTask=Task
}
import org.gradle.api.tasks.bundling { 
    GZip = Zip 
}

shared interface Project {
    
     shared formal Task task(String|Task task);  
   
   
}

shared abstract class DefaultTask(name) satisfies Task{
    
    shared actual String name;
    
    shared default actual DefaultTask doLast(TaskAction<Task> action) => nothing;
    
    
    
}


shared class SimpleTask(String name) extends DefaultTask(name){
    
    shared actual Object bridge => object extends Bridge<GTask>(){
       name => outer.name; 
    };
    
}
   
    
    
    


shared class Zip(name) extends DefaultTask(name) {
    String name;
    shared variable String baseName = "myzip";
    shared actual Zip doLast(TaskAction<Task> action) => nothing;
    
    shared actual Object bridge => object extends Bridge<GZip>(){
        name => outer.name; 
    };
}