extends CanvasLayer

@export var button_press_sound: AudioStream  # Sound effect for button press
var audio_player: AudioStreamPlayer  # Audio player for playing the sound

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Button.connect("pressed", self, "_on_button_pressed")
	audio_player = AudioStreamPlayer.new()  # Create a new audio player
	add_child(audio_player)  # Add it to the scene tree

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	# Play the button press sound
	if button_press_sound:
		audio_player.stream = button_press_sound  # Assign the sound to the audio player
		audio_player.play()  # Play the sound

	# Change to the new scene after a brief delay (optional)
	#yield(get_tree().create_timer(0.5), "timeout")  # Optional delay before switching scenes
	get_tree().change_scene_to_file("res://World/select_tutorials.tscn")
