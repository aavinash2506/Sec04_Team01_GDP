extends CanvasLayer

@export var color_change_speed = 0.5  # Speed of color change

var target_color = Color(0, 0, 0)  # Starting target color
var current_color = Color(1, 1, 1)  # Current background color

func _ready():
	# Set the initial background color
	self.modulate = current_color

func _process(delta):
	# Lerp towards the target color
	current_color = current_color.linear_interpolate(target_color, color_change_speed * delta)

	# Apply the current color to the background
	self.modulate = current_color

	# Randomly change the target color every few seconds
#		target_color = Color(randf(), randf(), randf())  # Set a new random color
