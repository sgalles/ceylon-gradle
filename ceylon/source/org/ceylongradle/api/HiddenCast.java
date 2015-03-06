package org.ceylongradle.api;

import org.gradle.api.Task;

class HiddenCast {
	public static <T extends Task> T cast(Task t){
		return (T)t;
	}
}
