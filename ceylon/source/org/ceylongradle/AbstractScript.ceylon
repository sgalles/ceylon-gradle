import org.ceylongradle.api {
    Project
}
import org.ceylongradle.internal.api {
    ProjectInternal
}
import org.gradle.api {
    GProject=Project
}
import ceylon.file {

    Path
}

shared abstract class AbstractScript(Object gProject) satisfies Project {
   
    shared Project project;
    
    assert(is GProject gProject);
    value prjInt = ProjectInternal(gProject);
    prjInt.task = prjInt.TaskHolder();
    project = prjInt;
    
    shared formal void execute();
    
    shared actual TaskHolder task {
        return project.task;
    }
    
    //task => project.task;
    
    buildDir => project.buildDir;
    
   
}