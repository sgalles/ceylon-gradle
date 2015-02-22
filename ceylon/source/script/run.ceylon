import org.ceylongradle {
    AbstractScript
}
import org.ceylongradle.api {
    Project,
    Zip,
    DefaultTask
}


shared  class Script(Object gProject) extends AbstractScript(gProject){
    
    
    
    shared actual void execute() {     
        
        task(Zip("myzip"));
        
        task("mytask").doLast(void(task) {
            print("Hello from Ceylon !");
        });
        
        
     
        //task<DefaultTask>("sayHello").doLast(void(t) {
        //    print("Hello from Ceylon !");
        //});
        //
        //task<Zip>("sayHello", void(Zip t) {
        //    t.baseName = "foo";
        //    t.doLast(void(t) {
        //        print("Hello from Ceylon !");
        //    });
        //});
        
                 
    }
 
   
  
    
}

