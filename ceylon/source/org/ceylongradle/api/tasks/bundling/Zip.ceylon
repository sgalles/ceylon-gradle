import org.ceylongradle.api {
    DefaultTask,
    Task,
    TaskAction
}
shared class Zip() extends DefaultTask() {
    shared variable String baseName = "myzip";
    shared actual Zip doLast(TaskAction<Task> action) => nothing;
}