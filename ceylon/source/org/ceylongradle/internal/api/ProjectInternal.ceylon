import ceylon.file {
    Path,
    parsePath
}
import ceylon.interop.java {
    javaClass,
    JavaCollection
}

import java.io {
    JFile=File
}

import org.ceylongradle.api {
    Project,
    PathSource,
    MultiPathSource,
    BasicMultiPathSource
}
import org.ceylongradle.api.file {
    FileCollection
}
import org.ceylongradle.internal.api.file.collection {
    FileCollectionImpl
}
import org.gradle.api {
    GProject=Project,
    GTask=Task
}
shared class ProjectInternal(shared GProject gproject) satisfies Project{
   
    
    shared actual late TaskHolder task;
    
    buildDir => toPath(gproject.buildDir);
    
    file(PathSource path) => toPath(gproject.file(toJFile(path)));
    
    files(MultiPathSource* paths) 
            => let(
                   colOfJFiles = toPaths(*paths).collect(toJFile),
                   gfilecollection = gproject.files(JavaCollection(colOfJFiles))
               ) FileCollectionImpl(gfilecollection);
                     
    
    shared void addRegistration<GTaskType>(String  name, void configure(GTaskType gtask))
            given GTaskType satisfies GTask{
        configure(createAndAdd<GTaskType>(name));
    }
    
    GTaskType createAndAdd<GTaskType>(String name) 
            given GTaskType satisfies GTask
            => gproject.tasks.create<GTaskType>(name, javaClass<GTaskType>());
    
       
}

shared Path toPath(PathSource|JFile path)
    => switch(path)
       case(is String) parsePath(path)
       case(is Path) path
       else if(is JFile path) then  parsePath(path.string) 
            else let(computedPath = path()) toPath(computedPath);
       

shared JFile toJFile(PathSource path) => JFile(toPath(path).string);
       
shared {Path*} toPaths(MultiPathSource* paths) => paths.flatMap(
           (mPath) => if(is [BasicMultiPathSource*] mPath) then mPath.flatMap(toPaths)
           else if(is FileCollection mPath) then mPath
           else {toPath(mPath)}
       );
          


