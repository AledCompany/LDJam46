extends KinematicBody2D

class_name Player


const gravity = 9810
export var speed = 300
export var acceleration = 300
export var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	pass # Replace with function body.


func _physics_process(delta):	
#	if is_on_floor() :
#		velocity.x = lerp(velocity.x, speed, acceleration * delta)
#		if Input.is_action_just_pressed("jump"):
#			velocity += Vector2.UP * 2000
#	else:
#		velocity += gravity * delta * Vector2.DOWN
#	print(velocity)
#	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += gravity * delta
	
	if is_on_floor():
		velocity.x = lerp(velocity.x , speed * direction.x, 10*delta)
		if Input.is_action_just_pressed("jump"):
			velocity += Vector2.UP * 2000
	
	velocity = move_and_slide(velocity, Vector2.UP)
#	print(velocity)
	pass

func _on_DeathZone_body_entered(body):
	get_tree().reload_current_scene();
	pass # Replace with function body.
