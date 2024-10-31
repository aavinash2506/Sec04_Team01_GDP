extends CanvasLayer

#func _ready():
	# Connect button signal to the function
	#$Button.connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	# Play transition effect, then change scene
	$TransitionEffect.play("fade_out")  # Assume there's a TransitionEffect node
	#yield($TransitionEffect, "animation_finished")
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")
