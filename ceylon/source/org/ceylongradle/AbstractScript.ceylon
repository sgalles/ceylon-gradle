import org.ceylongradle.api {
    Project,
    PathSource,
    MultiPathSource
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
    
    shared formal void execute();
    
    task => project.task;
    
    buildDir => project.buildDir;
    
    file(PathSource path) => project.file(path);
    
    files(MultiPathSource paths) => project.files(paths);
}