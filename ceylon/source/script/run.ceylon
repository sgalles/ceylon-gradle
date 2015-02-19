import org.ceylongradle {
    AbstractScript
}
import org.ceylongradle.api {
    Project,
    SimpleTask,
    Zip
}


shared  class Script(Project project) extends AbstractScript(project){
    
    
    
    shared actual void execute() {     
        
        task<SimpleTask>("sayHello").doLast(void(t) {
            print("Hello from Ceylon !");
        });
        
        task<Zip>("sayHello", void(Zip t) {
            t.baseName = "foo";
            t.doLast(void(t) {
                print("Hello from Ceylon !");
            });
        });
        
                 
    }
    
    
}

