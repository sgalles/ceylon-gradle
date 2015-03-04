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
    
    shared formal TaskHolder task;
    
    void addRegistrationInternal<GTaskType>(String  name, void configure(GTaskType gtask)) 
            given GTaskType satisfies GTask{
        projectInternal(this).addRegistration<GTaskType>(name, configure);
    }
    
    suppressWarnings("expressionTypeNothing")
    GTaskType matchingGTask<GTaskType>(Task task)  given GTaskType satisfies GTask {
        GTaskType gt = Transtyper.transtype(projectInternal(this).gproject.tasks.getByName(task.name)) ;
        //assert(is GTaskType gt); 
        return gt;
        
    }
    
    //suppressWarnings("expressionTypeNothing")
    /*GTaskType matchingGTask<GTaskType>(Task task)  given GTaskType satisfies GTask {
        GTask gt = projectInternal(this).gproject.tasks.getByName(task.name);
        assert(is GTaskType gt); 
        return gt;
        
    }*/
        
    
    shared class TaskHolder(){
            
            shared Project project => outer;
            
            shared class Simple(String name) extends DefaultTask(name) {
                addRegistrationInternal<GTask>(name, noop);
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
                    addRegistrationInternal<GZip>(name, configure);
                }
                
                GZip gtask => matchingGTask<GZip>(this);
                
                shared String baseName => gtask.baseName;
                assign baseName {  gtask.baseName = baseName;}
                
            }
            
            shared abstract class DefaultTask(name) satisfies Task {
                
                shared actual String name;
                
                shared actual DefaultTask doLast(Action<Task> action) {
                    
                    projectInternal(outer.project).gproject.tasks.getByName(name).doLast(object satisfies GAction<GTask> {
                        execute(GTask t) => action(outer);
                    });
                    return this;
                }
            }
            
    }
    
    
}

suppressWarnings("expressionTypeNothing")
ProjectInternal projectInternal(Project project) 
        => switch(project)
           case(is ProjectInternal) project
           case(is AbstractScript)  (if(is ProjectInternal prjInternal = project.project) then prjInternal else nothing)
           else nothing; 

      
