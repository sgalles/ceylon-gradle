import org.gradle.api {
    Project
}


shared class Foo(shared Project project){
    value a = project.configurations;
    print(a);
}

