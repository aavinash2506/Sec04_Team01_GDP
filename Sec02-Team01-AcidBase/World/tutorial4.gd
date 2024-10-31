extends CanvasLayer

#func _ready():
	#$Button.connect("pressed", self, "_on_button_pressed")

func _process(delta):
	pass

func _on_button_pressed():
	# Print confirmation message
	print("Button pressed! Loading new scene...")

	# Hide the button to prevent multiple presses
	$Button.visible = false

	# Change background color to a random color
	#modulate = Color(randf(), randf(), randf())

	# Switch to the new scene
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")
