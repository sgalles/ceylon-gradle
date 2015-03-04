This is an experiment to use Ceylon to write Gradle scripts.

The directories in the source tree are :
* `ceylon` A Ceylon project with :
* `ceylon/source/script` the Gradle script written in Ceylon
* `ceylon/source/org/ceylongradle` The Gradle/Ceylon binding library
* `src` The src directory for the plain Java Gradle test project (not yet used)
* `build.gradle` and `settings.gradle` The regular Gradle scripts used to bootstrap the Ceylon Gradle script.

To execute the Gradle script :
* compile the ceylon project in `ceylon`
* in the root directory try to run `gradle mytask`
