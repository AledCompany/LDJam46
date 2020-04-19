extends KinematicBody2D

class_name Player


const gravity = 1000

export var speed = 50
export var acceleration = 5

export var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var impulse = Vector2.ZERO

var isJumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	pass # Replace with function body.


func _physics_process(delta):	
	velocity.y += gravity * delta
	
	velocity.x = lerp(velocity.x , speed * direction.x, acceleration * delta)
	
	velocity = move_and_slide(velocity if impulse==Vector2.ZERO else impulse, Vector2.UP)
	impulse=Vector2.ZERO
	animation(is_on_floor(),velocity.y>0)

func animation(is_on_floor=false,is_falling=true):
	if is_on_floor:
		$AnimatedSprite.play("run")
	else:
		if is_falling:
			$AnimatedSprite.play("fall")
		else:
			$AnimatedSprite.play("jump")

func set_impulse(new_impulse):
	impulse=new_impulse

func _on_DeathZone_body_entered(body):
	if body == self:
		kill()
	pass # Replace with function body.


func kill():
	print("Player is dead...")
	get_tree().reload_current_scene();
