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
    Project,
    PathSource,
    BasicPathSource
}
import org.gradle.api {
    GProject=Project,
    GTask=Task
}
shared class ProjectInternal(shared GProject gproject) satisfies Project{
   
    
    shared actual late TaskHolder task;
    
    buildDir => toPath(gproject.buildDir);
    
    file(PathSource path) => toPath(gproject.file(toJFile(path)));
    
    shared void addRegistration<GTaskType>(String  name, void configure(GTaskType gtask))
            given GTaskType satisfies GTask{
        configure(createAndAdd<GTaskType>(name));
    }
    
    GTaskType createAndAdd<GTaskType>(String name) 
            given GTaskType satisfies GTask
            => gproject.tasks.create<GTaskType>(name, javaClass<GTaskType>());
    
       
}

shared Path toPath(PathSource|JFile path)
    => switch(path)
       case(is String) parsePath(path)
       case(is Path) path
       else if(is JFile path) then  parsePath(path.string) 
            else let(computedPath = path()) toPath(computedPath);
       

shared JFile toJFile(PathSource path) => JFile(toPath(path).string);

