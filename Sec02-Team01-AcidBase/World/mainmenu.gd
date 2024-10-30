extends CanvasLayer
#extends Button

@onready var shared_data = get_node("/root/Global")

# --------- VARIABLES ---------- #
var highscore = 0
# Called when the node enters the scene tree for the first time.

# --------- FUNCTIONS ---------- #



func _on_login_pressed():
	get_tree().change_scene_to_file("res://login/login_form.tscn")
	
	pass # Replace with function body.


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")
	pass # Replace with function body.

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://World/credits.tscn")
	pass # Replace with function body.


func _on_play_pressed():
	get_tree().change_scene_to_file("res://World/select_levels.tscn")
	pass # Replace with function body.

func _logout():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://login/login_form.tscn")


func _ready():
	$Panel/PanelContainer/VBoxContainer/play.disabled = true
	getCompundQuestions("questions")
	shared_data.getCurrentUser()
	
	
	
#func sendScore():
	#shared_data.sendScore("users", "10000")

func getCompundQuestions(collection_name: String): 
	var auth = Firebase.Auth.auth
	var db = Firebase.Firestore
	
		
	var query: FirestoreQuery = FirestoreQuery.new()
	query.from(collection_name)	
	var results = await Firebase.Firestore.query(query)

	if results.size() > 0 :
		for result in results:
			var doc_name = result['doc_name']
			var document = result["document"]
			var question = Questions.new(doc_name, document)
			shared_data.compoundArray.append([question.formulaValue, question.compoundType])
			$Panel/PanelContainer/VBoxContainer/play.disabled = false
			#print("product_data: "+str(result["document"])+ " user.type: "+str(question.compoundType
			#)+ " user.name:"+ str(question.formulaValue)+
			#"  compundarrSize: "+str(shared_data.compoundArray.size()))
			
	
