extends CanvasLayer

@export var button_hover_sound: AudioStream  # Sound effect for button hover
@export var button_click_sound: AudioStream  # Sound effect for button click
var audio_player: AudioStreamPlayer  # Audio player for playing the sounds

# Reference to the menu title label
var menu_title: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player = AudioStreamPlayer.new()  # Create a new audio player
	add_child(audio_player)  # Add it to the scene tree

	# Create and set up the menu title label
	menu_title = Label.new()
	menu_title.text = "Main Menu"  # Change this to your desired menu title
	menu_title.rect_position = Vector2(400, 50)  # Position it at the top center (adjust as needed)
	menu_title.visible = false  # Initially hidden
	add_child(menu_title)  # Add to the scene

	# Connect button signals
	#for button in get_children():  # Assuming buttons are direct children
		#if button is Button:
			#button.connect("mouse_entered", self, "_on_mouse_entered")
			#button.connect("mouse_exited", self, "_on_mouse_exited")
			#button.connect("pressed", self, "_on_button_pressed")

# Function to handle mouse hover effect
func _on_mouse_entered() -> void:
	self.scale = Vector2(1.1, 1.1)  # Scale the button up to 110%

	if button_hover_sound:
		audio_player.stream = button_hover_sound  # Assign the hover sound
		audio_player.play()  # Play the hover sound

func _on_mouse_exited() -> void:
	self.scale = Vector2(1, 1)  # Reset scale to original size

# Function to handle button press
func _on_button_pressed() -> void:
	if button_click_sound:
		audio_player.stream = button_click_sound  # Assign the click sound
		audio_player.play()  # Play the click sound

	# Show the menu title
	menu_title.visible = true  # Make the menu title visible

	# Optionally, change background color to indicate menu is active
	self.get_parent().modulate = Color(0.5, 0.5, 0.5, 1)  # Darken background (change as needed)

	# Change the scene when the button is pressed
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")  # Change this to your desired scene path
