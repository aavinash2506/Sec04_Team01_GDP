#extends CanvasLayer
#
#
#@onready var shared_data = get_node("/root/Global")
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#if (shared_data.user != null):
		#if(shared_data.current_lvl == 1 ):
			#$PanelContainer/ScrollContainer/Control/score.text = str(shared_data.user.highest_score_lvl_1)
		#elif (shared_data.current_lvl == 2):
			#$PanelContainer/ScrollContainer/Control/score.text = str(shared_data.user.highest_score_lvl_2)
		#else:
			#$PanelContainer/ScrollContainer/Control/score.text = ""
	#else:	
		#$PanelContainer/ScrollContainer/Control/score.text = "----"
	#
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
#
#
#
#
#func _on_button_pressed():
	#get_tree().change_scene_to_file("res://World/select_tutorials.tscn")



extends CanvasLayer

@onready var shared_data = get_node("/root/Global")

const TOTAL_LEVELS = 4  # Adjust if you add more levels

func _ready():
	if shared_data.user != null:
		print("User found:", shared_data.user)
		display_all_scores()
	else:
		print("User not available.")
		display_empty_scores()

# Display scores for all levels
func display_all_scores():
	for lvl in range(1, TOTAL_LEVELS + 1):
		var score_label_path = "PanelContainer/ScrollContainer/Control/score_" + str(lvl)
		var score_label = get_node_or_null(score_label_path)
		if score_label:
			var score_value = get_user_score_for_level(lvl)
			score_label.text = str("Level"+str(lvl)+":  "+score_value)
		else:
			push_error("Node not found: " + score_label_path)

# Fallback display if no user is available
func display_empty_scores():
	for lvl in range(1, TOTAL_LEVELS + 1):
		var score_label_path = "PanelContainer/ScrollContainer/Control/score_" + str(lvl)
		var score_label = get_node_or_null(score_label_path)
		if score_label:
			score_label.text = "----"

# Helper function to get the score for a given level
func get_user_score_for_level(level: int) -> String:
	match level:
		1:
			print(shared_data.user.highest_score_lvl_1)
			return shared_data.user.highest_score_lvl_1
		2:
			print(shared_data.user.highest_score_lvl_2)
			return shared_data.user.highest_score_lvl_2
		_:
			return "0"  # Default value for levels without a score

# Scene change handler
func _on_button_pressed():
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")
