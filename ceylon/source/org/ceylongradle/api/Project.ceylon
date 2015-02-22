
shared interface Project {
    
     shared formal Task task(String|Task task);  
   
   
}

shared class DefaultTask(name) satisfies Task{
    
    shared actual String name;
    
    shared default actual DefaultTask doLast(TaskAction<Task> action) => nothing;
    
    
    
}

shared class Zip(name) extends DefaultTask(name) {
    String name;
    shared variable String baseName = "myzip";
    shared actual Zip doLast(TaskAction<Task> action) => nothing;
}