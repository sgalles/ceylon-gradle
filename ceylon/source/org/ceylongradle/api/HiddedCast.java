package org.ceylongradle.api;

import org.gradle.api.Task;

class HiddedCast {
	public static <T extends Task> T transtype(Task t){
		return (T)t;
	}
}
