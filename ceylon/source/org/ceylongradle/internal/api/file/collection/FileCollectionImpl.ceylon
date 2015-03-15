import ceylon.file {
    Path
}
import ceylon.interop.java {
    CeylonIterable
}

import org.ceylongradle.api.file {
    FileCollection
}
import org.ceylongradle.internal.api {
    toPath
}
import org.gradle.api.file {
    GFileCollection=FileCollection
}

 
 
shared class FileCollectionImpl(shared GFileCollection delegate) satisfies FileCollection{
     
    value pathIterable = CeylonIterable(delegate).collect(toPath);
     
    shared actual Iterator<Path> iterator() => pathIterable.iterator();
            
   
   
    
    
}