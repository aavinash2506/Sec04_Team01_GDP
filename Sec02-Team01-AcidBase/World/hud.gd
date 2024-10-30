extends CanvasLayer

# --------- VARIABLES ---------- #
@onready var gameOverScreen = $Control
@onready var inGamePanel = $PanelContainer
@onready var moveNextLevelBtn = $Control/GameOverScreen/VBoxContainer/MoveToNextLevel
@onready var currentScore = $PanelContainer/HBoxContainer/CurrentScore
@onready var shared_data = get_node("/root/Global")

# --------- FUNCTIONS ---------- #
func _ready():
	gameOverScreen.hide()
	moveNextLevelBtn.hide()
	$Control/VictoryAnims.hide()
	
	
func _physics_process(delta):
	$Control/VictoryAnims/Duckdance.play("duck")
	$Control/VictoryAnims/PlayerVictory.play("player")
func game_start():
	inGamePanel.show()
	gameOverScreen.hide()
	$"..".restart()
	
func game_over():
	print("getCurrentUser.shared_data.gameover() screendisplay")
	inGamePanel.hide()
	gameOverScreen.show()
	$Control/GameOverScreen/VBoxContainer/HBoxContainer/Score.text = "Score:\n" + str($"..".score)
	var quizHighScore = $"..".highscore
	var level = $"..".level
	
	print("getCurrentUser.shared_data.user.first_name::"+str(shared_data.user==null))
	if (shared_data.user != null):
		if(level == 1 and quizHighScore < int(shared_data.user.highest_score_lvl_1)):
			$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = str(shared_data.user.first_name)+"\'s High Score:\n" + str(shared_data.user.highest_score_lvl_1)
		elif (level == 2 and quizHighScore < int(shared_data.user.highest_score_lvl_2)):
			$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = str(shared_data.user.first_name)+"\'s High Score:\n" + str(shared_data.user.highest_score_lvl_2)	
		else:
			$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = str(shared_data.user.first_name)+"\'s High Score:\n" + str($"..".highscore)	
	else:	
		$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = "High Score:\n" + str($"..".highscore)
	
func _on_restart_pressed():
	game_start()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res:///World/select_levels.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")

func _on_option_button_item_selected(index):
	match index:
		0:  quit_game()
		1:  pause_game()
		2:  resume_game()
	pass # Replace with function body.

func quit_game():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://World/select_levels.tscn") # Quits the game.

func pause_game():
	get_tree().paused = true # Pauses the game.
	#show() # Ensure the menu remains visible.

func resume_game():
	get_tree().paused = false # Resumes the game. 
	#show()

func _on_move_to_next_lvl_pressed():
	if (shared_data.current_lvl == 1):
		var new_scene = load("res://World/lvl_1.tscn").instantiate()
		shared_data.current_lvl = 2
		new_scene.level = 2
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.call_deferred("free")
		get_tree().current_scene = new_scene
	elif (shared_data.current_lvl == 2):
		var new_scene = load("res://World/lvl_1.tscn").instantiate()
		new_scene.level = 3
		shared_data.current_lvl = 3
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.call_deferred("free")
		get_tree().current_scene = new_scene
	elif (shared_data.current_lvl == 3):
		var new_scene = load("res://World/lvl_1.tscn").instantiate()
		new_scene.level = 4
		shared_data.current_lvl = 4
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.call_deferred("free")
		get_tree().current_scene = new_scene
	pass
	
	#get_tree().change_scene_to_file("res://World/select_levels.tscn")
