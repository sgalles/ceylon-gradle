import org.ceylongradle {
    AbstractScript
}


shared  class Script(Object gProject) extends AbstractScript(gProject){
    
    
    
    shared actual void execute() {     
        
        
        value z = task.Zip{
            name= "myzip";
            baseName = "mybasename";
            from = "ceylon";
        };
        z.baseName = "mybasename2";
        
        task.Simple{
            name = "mytask";
        }.doLast(void(task) {
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

