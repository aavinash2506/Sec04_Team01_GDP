extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_return_to_main_pressed():
	get_tree().change_scene_to_file("res://World/menu.tscn")
	pass # Replace with function body.


func _on_tutorial_1_pressed():
	get_tree().change_scene_to_file("res://World/tutorial.tscn")
	pass # Replace with function body.

func _on_tutorial_2_pressed():
	get_tree().change_scene_to_file("res://World/tutorial2.tscn")
	pass # Replace with function body.

func _on_tutorial_3_pressed():
	get_tree().change_scene_to_file("res://World/tutorial3.tscn")
	pass # Replace with function body.

func _on_tutorial_4_pressed():
	get_tree().change_scene_to_file("res://World/tutorial4.tscn")
	pass # Replace with function body.
