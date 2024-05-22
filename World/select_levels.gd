extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	_disable_buttons()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _disable_buttons():
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level1.disabled = false
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level2.disabled = false
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level3.disabled = false
	$Panel/PanelContainer/HBoxContainer/VBoxContainer/Level4.disabled = false


func _on_level_1_pressed():
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	new_scene.level = 1
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	#get_tree().change_scene_to_file("res://World/lvl_1.tscn")
	pass # Replace with function body.


func _on_level_2_pressed():
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	new_scene.level = 2
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	pass # Replace with function body.


func _on_level_3_pressed():
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	new_scene.level = 3
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	pass # Replace with function body.


func _on_level_4_pressed():
	var new_scene = load("res://World/lvl_1.tscn").instantiate()
	new_scene.level = 4
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.call_deferred("free")
	get_tree().current_scene = new_scene
	pass # Replace with function body.


