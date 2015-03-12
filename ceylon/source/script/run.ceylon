import org.ceylongradle {
    AbstractScript
}


shared  class Script(Object gProject) extends AbstractScript(gProject){
    
    
    
    
    shared actual void execute() {     
        
       
        
        value z = task.Zip{
            name= "myzip";
            from = "ceylon";
            destinationDir = file("``buildDir``/distribution");
        };
        z.baseName = "mybasename3";
        
        task.Simple{
            name = "mytask";
        }.doLast(void(task) {
            print("Hello from Ceylon !");
        });
        
                 
    }
    
}

