extends CharacterBody2D

const SPEED = 98
@export var cel_node: Node2D  # Reference to the "Cel" node
@export var label_node: Label  # Reference to the "Label" node that displays points
@export var sprite = AnimatedSprite2D
@onready var bllsprite = $AnimatedSprite2D  # Reference to the animated sprite for the Ball
var points = 0  # Points counter
var on_cel = false  # Whether the Ball is on the target
var timer = 0.0  # Timer for time spent on the target
const WAIT_TIME = 1.0  # Time the Ball needs to stay on the target to gain a point (1 second)

# Scaling of the target
var original_cel_scale = Vector2.ONE  # Original size of the target
@export var min_cel_scale = 0.6  # Minimum size of the target after 1 second

func _ready():
	# Initialize the points value
	label_node.text = str(points)
	original_cel_scale = cel_node.scale  # Store the original size of the target

func _physics_process(delta):
	# Read accelerometer input (values may be zero by default in the emulator)
	var acc = Input.get_accelerometer()

	# Set velocity based on the accelerometer input
	velocity.x = acc.x * SPEED
	velocity.y = -acc.y * SPEED

	# Move the ball
	move_and_slide()

	# Check for collision with the target (Cel)
	if is_colliding_with_cel():
		if not on_cel:
			on_cel = true  # Ball entered the target
			timer = 0.0  # Reset timer
		else:
			# If the Ball stays on the target, increase the timer
			timer += delta
			var scale_factor = lerp(1.0, min_cel_scale, timer / WAIT_TIME)
			cel_node.scale = original_cel_scale * scale_factor  # Shrink the target size

			if timer >= WAIT_TIME:
				on_collision_with_cel()  # Add a point if the Ball stayed on the target for 1 second
				timer = 0.0  # Reset timer
	else:
		# If the Ball leaves the target, reset the target size
		on_cel = false
		timer = 0.0
		cel_node.scale = original_cel_scale  # Reset the target size

# Function to check for collision with the target
func is_colliding_with_cel() -> bool:
	# Use global_transform to check the positions of the two objects
	return global_position.distance_to(cel_node.global_position) < 60  # Assuming a small collision distance of 60px

# Function to handle collision with the target
func on_collision_with_cel():
	points += 1 
	label_node.text = str(points)  
	randomize_cel_position()  
	cel_node.scale = original_cel_scale  

	
	if points == 20:
		bllsprite.stop()
		bllsprite.play(&"skin")  
	if points == 50:
		bllsprite.stop()
		bllsprite.play(&"ballin")  

	if points == 100:
		bllsprite.stop()
		bllsprite.play(&"og")  

func randomize_cel_position():
	var random_x = randf_range(-850, 1400)  
	var random_y = randf_range(-400, 500)  
	cel_node.position = Vector2(random_x, random_y)
