import ceylon.file {
    Path,
    parsePath
}
import ceylon.interop.java {
    javaClass
}

import java.io {
    JFile=File
}

import org.ceylongradle.api {
    Project
}
import org.gradle.api {
    GProject=Project,
    GTask=Task
}
shared class ProjectInternal(shared GProject gproject) satisfies Project{
   
    
    shared actual late TaskHolder task;
    
    shared actual Path buildDir => parsePath(gproject.buildDir.string);
    
    shared void addRegistration<GTaskType>(String  name, void configure(GTaskType gtask))
            given GTaskType satisfies GTask{
        configure(createAndAdd<GTaskType>(name));
    }
    
    GTaskType createAndAdd<GTaskType>(String name) 
            given GTaskType satisfies GTask
            => gproject.tasks.create<GTaskType>(name, javaClass<GTaskType>());
    
       
}

shared JFile toFile(String|Path path)
    => switch(path)
       case(is String) JFile(path)
       case(is Path) JFile(path.string);

