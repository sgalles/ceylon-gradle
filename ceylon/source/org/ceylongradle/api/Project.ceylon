import ceylon.file {
    Path
}

import org.ceylongradle {
    AbstractScript
}
import org.ceylongradle.api.file {
    FileCollection
}
import org.ceylongradle.internal.api {
    ProjectInternal,
    toJFile
}
import org.ceylongradle.internal.api.file.collection {
    FileCollectionImpl
}
import org.gradle.api {
    GTask=Task,
    GAction=Action
}
import org.gradle.api.tasks.bundling {
    GZip=Zip
}


shared alias BasicPathSource => String|Path;
shared alias PathSource => BasicPathSource|BasicPathSource();
//shared alias BasicMultiPathSource => PathSource|Task|TaskOutputs;
shared alias BasicMultiPathSource => PathSource;
shared alias MultiPathSource => BasicMultiPathSource|[BasicMultiPathSource*]|FileCollection/*|[BasicMultiPathSource*]?()*/;

shared interface Project {
    
    shared formal TaskHolder task;
    
    shared formal Path buildDir;
    
    shared formal Path file(PathSource path); 
    
    // ici FileCollection not imported => bug
    shared formal FileCollection files(MultiPathSource* paths);
    
    void addRegistrationInternal<GTaskType>(String  name, void configure(GTaskType gtask)) 
            given GTaskType satisfies GTask{
        projectInternal(this).addRegistration<GTaskType>(name, configure);
    }
    

    GTaskType matchingGTask<GTaskType>(Task task)  given GTaskType satisfies GTask 
        => if(is GTaskType gt = projectInternal(this).gproject.tasks.getByName(task.name)) 
           then gt else nothing;
           
    
    shared class TaskHolder(){
            
            shared Project project => outer;
            
            shared class Simple(String name) extends DefaultTask(name) {
                addRegistrationInternal<GTask>(name, noop);
            }
            
            shared class Zip extends DefaultTask {
                
                shared new (
                    String name, 
                    MultiPathSource from, 
                    String? baseName = null, 
                    PathSource? into = null,
                    PathSource? destinationDir = null
                ) extends DefaultTask(name){
                    void configure(GZip gtask){
                        if(exists baseName){
                            gtask.baseName = baseName;
                        }
                        // TODO avoid case
                        assert(is FileCollectionImpl f = files(from));
                        gtask.from(f.delegate);
                        if(exists into) {
                            gtask.into(toJFile(into));
                        }
                        if(exists destinationDir) {
                            gtask.destinationDir = toJFile(destinationDir);
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

      
