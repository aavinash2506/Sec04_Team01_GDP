extends Button
#extends Node2D

# Get references to UI elements
@onready var email_input = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/email_input
#@onready var password_input = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/password_input
@onready var password_input = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/password_line_edit
@onready var feedback_label = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/feedback_label
@onready var first_name_input = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/first_name
@onready var last_name_input = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/last_name
@onready var login_button = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/Login
@onready var signup_button = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/Signup
@onready var create_account_button = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/create_account
@onready var already_account_button = $/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/already_account



var firebase = null

	
func _ready():
	
	var firebase_config = {
			"apiKey": "AIzaSyCLISdftVxzhPWSVUuYc7osmEg6v4fomTQ",
			"authDomain": "acidbasegame-a9d8a.firebaseapp.com",
			"projectId": "acidbasegame-a9d8a",
			"storageBucket": "acidbasegame-a9d8a.appspot.co",
			"messagingSenderId": "1038707828573",
			"appId": "1:1038707828573:web:56a1902384530d98a3aab4"
		}
	

	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	$/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/Signup.connect("pressed", _on_register_button_pressed)
	$/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/Login.connect("pressed", _on_login_button_pressed)
	email_input.connect("text_changed", _on_email_text_changed)
	password_input.connect("text_changed", _on_email_text_changed)
	$/root/Account_Create/menu/Panel/PanelContainer/VBoxContainer/create_account.connect("pressed", _on_create_account_pressed)
	already_account_button.connect("pressed", _on_already_account_pressed)
	first_name_input.visible = not first_name_input.visible
	last_name_input.visible = not last_name_input.visible
	
	feedback_label.visible = not feedback_label.visible
	signup_button.visible = not signup_button.visible
	already_account_button.visible = not already_account_button.visible
	
	if Firebase.Auth.check_auth_file():
		feedback_label.text = "Already Logged in"
		get_tree().change_scene_to_file("res://World/menu.tscn")


func _on_create_account_pressed():
	print("press create account")
	
	last_name_input.visible =  not last_name_input.visible
	first_name_input.visible =  not first_name_input.visible
	create_account_button.visible = not create_account_button.visible
	login_button.visible =  not login_button.visible
	signup_button.visible =  not signup_button.visible
	already_account_button.visible =  not already_account_button.visible
	
func _on_already_account_pressed():
	last_name_input.visible = not last_name_input.visible
	first_name_input.visible = not first_name_input.visible
	create_account_button.visible = not create_account_button.visible
	login_button.visible =  not login_button.visible
	signup_button.visible = not signup_button.visible
	already_account_button.visible = not already_account_button.visible
	
func _on_register_button_pressed():
	var email = email_input.text.strip_edges()
	var password = password_input.text.strip_edges()
	feedback_label.text = ""
	if validate_user_info(email, password):
		register_user(email, password)
	else:
		print("else")


func _on_login_button_pressed():
	var email = email_input.text.strip_edges()
	var password = password_input.text.strip_edges()
	feedback_label.text = ""
	if validate_user_info(email, password):
		login_user(email, password)
	else:
		print("else")


func validate_user_info(email, password) -> bool:
	feedback_label.text = ""
	if email == "" or password == "":
		feedback_label.text = "Please fill in all fields."
		return false
	return true	

func register_user(email: String, password: String):
	feedback_label.text = "Logging in...."
	Firebase.Auth.signup_with_email_and_password(email, password)


func login_user(email: String, password: String):
	feedback_label.text = "Logging in...."
	Firebase.Auth.login_with_email_and_password(email, password)

func _on_email_text_changed(new_text: String):
	print("on email text changed...."+new_text)
	feedback_label.text = ""


func on_login_succeeded(auth):
	print(auth)
	feedback_label.text = "Login success!"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://World/menu.tscn")
	


func on_signup_succeeded(auth):
	print(auth)
	feedback_label.text = "Sign up success!"
	
	var data_to_save = {
		"first_name": str(first_name_input.text.strip_edges()),
		"last_name": str(last_name_input.text.strip_edges()),
		"email": str(email_input.text.strip_edges())
	}
	Firebase.Auth.save_auth(auth)
	saveUserData("users")



func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	feedback_label.text = "Login failed. Error: %s" % message


func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	feedback_label.text = "Sign up failed. Error: %s" % message




var api_key = "AIzaSyCLISdftVxzhPWSVUuYc7osmEg6v4fomTQ"
var project_id = "acidbasegame-a9d8a"



func saveUserData(collection_name: String): 
	var auth = Firebase.Auth.auth
	var db = Firebase.Firestore
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(collection_name)
		var data: Dictionary = {
					"first_name": first_name_input.text.strip_edges(),
					"last_name": last_name_input.text.strip_edges(),
					"email" : email_input.text.strip_edges(),
					#"highest_score": 0
		}
		var task: FirestoreDocument = await collection.add(auth.localid, data)
		#var docId = "WYvNsETgYnRfSY1n51fG"
		#var collection2: FirestoreCollection = Firebase.Firestore.collection("questions")
		#var cc = await collection2.get_children()
		#print("ccc1:::::"+str(cc))
		#
		#var cc2 = await Firebase.Firestore.get("questions")
		#print("ccc2:::::"+str(cc2))
		#var task = await collection2.get()
	
		_on_already_account_pressed()
		
	
func _on_task_completed1(success: bool, error: String):
	if success:
		print("Data updated successfully!")
	else:
		print("Error updating data: %s" % error)	

#func save_to_firestore(collection_name: String, data: Dictionary) -> void:
	##var url = "https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents/%s?key=%s" % [project_id, collection_name, api_key]
	#var url = "https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents/%s?key=%s" % [project_id, collection_name, api_key]
	#var json_data = JSON.stringify(data)  
#
	#print(str(url));
	#print(str(json_data));
	#var headers = ["Content-Type: application/json"]
	#var http_request = HTTPRequest.new()
	#add_child(http_request)
#
	##var error = http_request.request(url, headers, false, HTTPClient.METHOD_POST, json_data)
	#var error = http_request.request(url, headers,  HTTPClient.METHOD_POST, json_data)
#
#
	#if error != OK:
		#feedback_label.text = "Error sending request: %s" % str(error)
		#return
	#
	##http_request.request_completed.connect( self, "_on_request_completed")
	#http_request.request_completed.connect(self._on_request_completed)
#
#func _on_request_completed(result, response_code, headers, body):
	#if response_code == 200:
		#print("Data saved successfully!")
	#else:
		#print("Error saving data: ", response_code, body.get_string_from_utf8())
