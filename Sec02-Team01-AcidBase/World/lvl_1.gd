extends Node2D

var level = 0
# total 30 questions will come and 7 correct answeres are needed to move on second stage
#static var total_qus_lvl_1 = 15
var total_correct_qus_lvl_1 = 10
var current_question_number = 0

# --------- VARIABLES ---------- #
signal projectile_finished
@onready var fullHeart = preload("res://healthFull.png")
@onready var halfHeart = preload("res://healthHalf.png")
@onready var level1 = preload("res://Assets/Textures/Ocean-and-Clouds-Free-Pixel-Art-Backgrounds.png")
@onready var level2 = preload("res://Assets/Textures/preview.png")
@onready var level3 = preload("res://Assets/Textures/env-preview-big.png")
@onready var level4 = preload("res://Assets/Textures/PnalIm (1).png")
@onready var score = 0
#@onready var currentQues = 0
@onready var highscore = 0
@onready var paused = false
@onready var player_dead = false
@onready var victory = false
@onready var shared_data = get_node("/root/Global")

# --------- FUNCTIONS ---------- #
func _ready():
	print("level---- "+str(level)+"   total_qus_lvl_1:: "+str(shared_data.total_qus_lvl_1))
	$hud/PanelContainer/HBoxContainer/ProgressBar.max_value = total_correct_qus_lvl_1
	$hud/PanelContainer/HBoxContainer/ProgressBar.show_percentage = false
	$hud/PanelContainer/HBoxContainer/CurrentScore.text = str(score)+"/"+str(shared_data.total_qus_lvl_1)
	$hud/PanelContainer/HBoxContainer/ProgressBar/RichTextLabel.text = "0/10"
	if level == 1:
		shared_data.duration = 3.0
		total_correct_qus_lvl_1 = 7
		$MovingBackground/ParallaxLayer/Background.texture = level1
		$hud/PanelContainer/HBoxContainer/ProgressBar.max_value = total_correct_qus_lvl_1
	if level == 2:
		shared_data.duration = 3.0
		total_correct_qus_lvl_1 = 7
		$MovingBackground/ParallaxLayer/Background.texture = level2
		$hud/PanelContainer/HBoxContainer/ProgressBar.max_value = total_correct_qus_lvl_1
	if level == 3:
		shared_data.duration = 3.0
		total_correct_qus_lvl_1 = 7
		$MovingBackground/ParallaxLayer/Background.texture = level3
		$hud/PanelContainer/HBoxContainer/ProgressBar.max_value = total_correct_qus_lvl_1
	if level == 4:
		shared_data.duration = 3.0
		total_correct_qus_lvl_1 = 7
		$MovingBackground/ParallaxLayer/Background.texture = level4
		$hud/PanelContainer/HBoxContainer/ProgressBar.max_value = total_correct_qus_lvl_1
		

func update_score():
	print("player_dead...upodatescore:: "+str(player_dead)+"   total_qus_lvl_1:: "+str(shared_data.total_qus_lvl_1)+
	"  total_correct_qus_lvl_1: "+str(total_correct_qus_lvl_1)+
	"  player_dead: "+str(player_dead));
	#currentQues = currentQues + 1
	current_question_number += 1
	$hud/PanelContainer/HBoxContainer/CurrentScore.text = str(current_question_number)+"/"+str(shared_data.total_qus_lvl_1)
	if not player_dead:

		$hud/PanelContainer/HBoxContainer/ProgressBar.value += 1
		
		score += 1
		$hud/PanelContainer/HBoxContainer/ProgressBar/RichTextLabel.text = str(score)+"/10"
		
		print("player_dead...progressbar.value: "+str($hud/PanelContainer/HBoxContainer/ProgressBar.value))
		#current_question_number += 1
		#if score>10:
			#get_tree().change_scene_to_file("res://World/select_levels.tscn")
		if (highscore<score):
			highscore = score
	
		if (level == 1 || level == 2 || level == 3 || level == 4):
			if (score >= total_correct_qus_lvl_1):
				victory = true
				gameover()
			elif (current_question_number == shared_data.total_qus_lvl_1):
				gameover()
			else:
				print("lvl1.....else.......")
#		for other levels
		#elif (score >= 15):
		elif (score >= shared_data.total_qus_lvl_1):
			victory = true
	#$hud/PanelContainer/HBoxContainer/Score.text = "Score:\n" + str(score)
	
	

func update_score_old():
	
	if not player_dead:
		#print("update_score_old..previous:: "+str(score)+"  score+1 = "+str(score+1))
		$hud/PanelContainer/HBoxContainer/ProgressBar.value+=1
		score += 1
		
		#print("score: "+str(score)+"  highscore: "+str(highscore))
		#if score>10:
			#get_tree().change_scene_to_file("res://World/select_levels.tscn")
		if (highscore<score):
			highscore = score
		if (score >= 8):
			victory = true
	#$hud/PanelContainer/HBoxContainer/Score.text = "Score:\n" + str(score)
	
	
func update_lives(lives: int):
	shared_data.duration = 3.0
	if lives == 6:
		$hud/PanelContainer/HBoxContainer/First.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Second.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Third.set_texture(fullHeart)
	elif lives == 5:
		$hud/PanelContainer/HBoxContainer/First.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Second.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Third.set_texture(halfHeart)
	elif lives == 4:
		$hud/PanelContainer/HBoxContainer/First.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Second.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Third.set_texture(null)
	elif lives == 3:
		$hud/PanelContainer/HBoxContainer/First.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Second.set_texture(halfHeart)
		$hud/PanelContainer/HBoxContainer/Third.set_texture(null)
	elif lives == 2:
		$hud/PanelContainer/HBoxContainer/First.set_texture(fullHeart)
		$hud/PanelContainer/HBoxContainer/Second.set_texture(null)
		$hud/PanelContainer/HBoxContainer/Third.set_texture(null)
	elif lives == 1:
		$hud/PanelContainer/HBoxContainer/First.set_texture(halfHeart)
		$hud/PanelContainer/HBoxContainer/Second.set_texture(null)
		$hud/PanelContainer/HBoxContainer/Third.set_texture(null)
	elif lives <= 0:
		$hud/PanelContainer/HBoxContainer/First.set_texture(null)
		$hud/PanelContainer/HBoxContainer/Second.set_texture(null)
		$hud/PanelContainer/HBoxContainer/Third.set_texture(null)
		gameover()
		
func _on_projectile_finished():
	update_score()
	#print("player_dead   _on_projectile_finished..player_dead: "+str(player_dead))
	player_dead = false
	
func gameover():
	paused = true
	shared_data.duration = 3.0
#	send score to firebase
	shared_data.sendScore("users", str(score), level)
	$hud.game_over()
	if (victory):
		$hud/Control/GameOverScreen/VBoxContainer/GameOverText.set_text("You Win!")
		$hud/Control/GameOverScreen/VBoxContainer/MoveToNextLevel.show()
		$hud/Control/VictoryAnims.show()
	set_process(false)
	set_physics_process(false)
	$enemy.set_process(false)
	$enemy.set_physics_process(false)
	# send core to fb
	
	
	
func restart():
	print("restart--")
	paused = false
	player_dead = false
	set_process(true)
	set_physics_process(true)
	$enemy.set_process(true)
	$enemy.set_physics_process(true)
	$enemy.attack_timer.start()
	score = -1
	# reset duration
	shared_data.duration = 3.0
	update_score()
	$hud/PanelContainer/HBoxContainer/ProgressBar.value=0
	$player_Lvl1.lives = 6
	update_lives(6)
	$player_Lvl1.set_position(Vector2(155, -300))
	$player_Lvl1.respawn_tween()
	current_question_number = 0
	#currentQues = 0
	$hud/PanelContainer/HBoxContainer/CurrentScore.text = "0/"+str(shared_data.total_qus_lvl_1)
	$hud/PanelContainer/HBoxContainer/ProgressBar/RichTextLabel.text = "0/10"
