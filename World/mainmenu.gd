extends CanvasLayer
# --------- VARIABLES ---------- #
var highscore = 0
# Called when the node enters the scene tree for the first time.

# --------- FUNCTIONS ---------- #


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")
	pass # Replace with function body.

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://World/credits.tscn")
	pass # Replace with function body.


func _on_play_pressed():
	get_tree().change_scene_to_file("res://World/select_levels.tscn")
	pass # Replace with function body.
