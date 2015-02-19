shared class DefaultTask() satisfies Task{
    
    shared default actual DefaultTask doLast(TaskAction<Task> action) => nothing;
    
    
}