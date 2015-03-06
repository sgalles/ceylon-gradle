package org.ceylongradle.api;

import org.gradle.api.Task;

class Transtyper {

	public static <T extends Task> T transtype(Task t){
		//System.out.println(t.getClass().getClassLoader());
		return (T)t;
	}
}
