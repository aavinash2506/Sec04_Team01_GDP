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
	
	print("getCurrentUser.shared_data.user.first_name::"+str(shared_data.user.first_name))
	if (shared_data.user != null):
		if(level == 1 and quizHighScore < int(shared_data.user.highest_score_lvl_1)):
			$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = str(shared_data.user.first_name)+"\'s High Score:\n" + str(shared_data.user.highest_score_lvl_1)
		elif (level == 2 and quizHighScore < int(shared_data.user.highest_score_lvl_2)):
			$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = str(shared_data.user.first_name)+"\'s High Score:\n" + str(shared_data.user.highest_score_lvl_2)	
		else:
			$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = str(shared_data.user.first_name)+"\'s High Score:\n" + str($"..".highscore)	
	else:	
		$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = str(shared_data.user.first_name)+"\'s High Score:\n" + str($"..".highscore)
	
func _on_restart_pressed():
	game_start()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res:///World/select_level.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")

func _on_option_button_item_selected(index):
	match index:
		0:  quit_game()
		1:  pause_game()
		2:  resume_game()
	pass # Replace with function body.

func quit_game():
	get_tree().change_scene_to_file("res://World/select_levels.tscn") # Quits the game.

func pause_game():
	get_tree().paused = true # Pauses the game.
	#show() # Ensure the menu remains visible.

func resume_game():
	get_tree().paused = false # Resumes the game. 
	#show()

func _on_move_to_next_lvl_pressed():
	get_tree().change_scene_to_file("res://World/select_levels.tscn")
