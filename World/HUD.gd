extends CanvasLayer

# --------- VARIABLES ---------- #
@onready var gameOverScreen = $Control
@onready var inGamePanel = $PanelContainer

# --------- FUNCTIONS ---------- #
func _ready():
	gameOverScreen.hide()
	$Control/VictoryAnims.hide()
	

func _physics_process(delta):
	$Control/VictoryAnims/Duckdance.play("duck")
	$Control/VictoryAnims/PlayerVictory.play("player")
func game_start():
	inGamePanel.show()
	gameOverScreen.hide()
	$"..".restart()
	
func game_over():
	inGamePanel.hide()
	gameOverScreen.show()
	$Control/GameOverScreen/VBoxContainer/HBoxContainer/Score.text = "Score:\n" + str($"..".score)
	$Control/GameOverScreen/VBoxContainer/HBoxContainer/HighScore.text = "High Score:\n" + str($"..".highscore)
	
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
