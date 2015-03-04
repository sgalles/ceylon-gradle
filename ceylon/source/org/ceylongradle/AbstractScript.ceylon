import org.ceylongradle.api {
    Project,
    Task
}
import org.ceylongradle.internal.api {
    ProjectInternal
}
import org.gradle.api {
    GProject=Project
}

shared abstract class AbstractScript(Object gProject) satisfies Project {
    
    shared Project project;
    
    assert(is GProject gProject);
    value prjInt = ProjectInternal(gProject);
    prjInt.task = prjInt.TaskHolder();
    project = prjInt;
    
    shared actual TaskHolder task {
        return project.task;
    }
    
    shared formal void execute();
   
}