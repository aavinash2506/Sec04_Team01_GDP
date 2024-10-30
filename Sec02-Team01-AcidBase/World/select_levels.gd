extends CanvasLayer


@onready var shared_data = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("select_lvl_ready")
	_disable_buttons()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("select_lvl_ready_process")
	pass
	

func _disable_buttons():
	print("disablebuttons")
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level1.disabled = false
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level2.disabled = false
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level3.disabled = false
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level4.disabled = false


func _on_level_1_pressed():
	print("presssss-----1111111")
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	new_scene.level = 1
	shared_data.current_lvl = 1
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	#get_tree().change_scene_to_file("res://World/lvl_1.tscn")
	pass # Replace with function body.


func _on_level_2_pressed():
	print("presssss-----222222")
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	shared_data.current_lvl = 2
	new_scene.level = 2
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	pass # Replace with function body.


func _on_level_3_pressed():
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	new_scene.level = 3
	shared_data.current_lvl = 3
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	pass # Replace with function body.


func _on_level_4_pressed():
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	new_scene.level = 4
	shared_data.current_lvl = 4
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	pass # Replace with function body.
