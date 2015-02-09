import ceylon.interop.java {
    javaClass,
    javaObjectArray,
    javaString
}

import ceylongradlebridge {
    AbstractScript
}

import java.lang {
    Class
}

import org.gradle.api {
    Project,
    Task
}
import org.gradle.api.tasks.bundling {
    Zip
}


shared class Script(Project project) extends AbstractScript(project){
    
    
    
    shared actual void execute() {
     
        
        
        task("sayHello", void(Task t) {
            print("Hello from Ceylon !");
        });
        
        value zip = task<Zip>("zip");
        zip.from(javaString("src"));
        zip.baseName = "myzip";
        
             
    }
}

