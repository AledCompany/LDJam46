extends KinematicBody2D

class_name Player


const gravity = 9810
export var speed = 100
export var acceleration = 10
export var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var isGrounded = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	pass # Replace with function body.


func _physics_process(delta):	
	velocity.y += gravity * delta
	
	if is_on_floor():
		if !isGrounded:
			$AnimatedSprite.play("run")
			isGrounded = true
		velocity.x = lerp(velocity.x , speed * direction.x, acceleration * delta)

		if Input.is_action_just_pressed("jump"):
			velocity += Vector2.UP * 2000		
	
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func _on_DeathZone_body_entered(body):
	get_tree().reload_current_scene();
	pass # Replace with function body.
	
func setAnimationJumping():
	$AnimatedSprite.play("jump")
	isGrounded = false
