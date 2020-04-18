extends KinematicBody2D


const gravity = 98.1
export var speed = 500
export var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	if is_on_floor() :
		velocity = direction * speed
		velocity.y = gravity
		if Input.is_action_just_pressed("jump"):
			velocity += Vector2.UP * 2000
	else:
		velocity += gravity * Vector2.DOWN
	print(velocity)
	move_and_slide(velocity, Vector2.UP)
	pass


func _on_DeathZone_body_entered(body):
	get_tree().reload_current_scene()
	pass # Replace with function body.
