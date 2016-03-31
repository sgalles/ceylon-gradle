This is an experiment to use Ceylon to write Gradle scripts.

State of this project
--------------------
Not usable. This was a simple experiment but basically I won't work on this anymore as there are better way to integrate Gradle+Ceylon, arguably using the Gradle embeddable API for instance

Description
--------------------

The Ceylon-Gradle script is [here](https://github.com/sgalles/ceylon-gradle/blob/master/ceylon/source/script/run.ceylon)

The directories in the source tree are :
* `ceylon` A Ceylon project with :
* `ceylon/source/script` the Gradle script written in Ceylon
* `ceylon/source/org/ceylongradle` The Gradle/Ceylon binding library
* `src` The src directory for the plain Java Gradle test project (not yet used)
* `build.gradle` and `settings.gradle` The regular Gradle scripts used to bootstrap the Ceylon Gradle script.

To execute the Gradle script :
* You need Gradle in your PATH
* You must import this [Gradle fatjar](http://stephane.galles.free.fr/ceylon/misc/tests/gradleall-2.2.1.jar) in your Ceylon repos as `gradleall/2.2.1`
* compile the ceylon project located in `ceylon` directory (via the Ceylon CLI `ceylon compile` or import the Ceylon project in the Ceylon IDE)
* in the root directory try to run `gradle mytask` to execute one task define in `ceylon/source/script`
