import org.gradle.api {
    GTask=Task
}
shared interface Bridge {
    
    shared formal GTask createAndAdd(ProjectInternal project);
    
}