extends KinematicBody2D

class_name Player

signal dead

const gravity = 1000

export var speed = 50
export var acceleration = 5

export var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var impulse = Vector2.ZERO
var dead=false
var isJumping = false
var enveloppe = false
var timer =0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	pass # Replace with function body.

func _process(delta):
	timer+=delta

func _physics_process(delta):	
	velocity.y += gravity * delta
	if !dead:
		velocity.x = lerp(velocity.x , speed * direction.x, acceleration * delta)
	else:
		velocity.x=lerp(velocity.x , 0, acceleration * delta)
		impulse=Vector2.ZERO
	velocity = move_and_slide(velocity if impulse==Vector2.ZERO else impulse, Vector2.UP)
	impulse=Vector2.ZERO
	animation(is_on_floor(),velocity.y>0)
	if position.y>64:
		kill()

func animation(is_on_floor=false,is_falling=true):
	if dead:
		$AnimatedSprite.play("die")
	else:
		if is_on_floor:
			$AnimatedSprite.play("run")
		else:
			if is_falling:
				$AnimatedSprite.play("fall")
			else:
				$AnimatedSprite.play("jump")

func set_impulse(new_impulse):
	if !dead:
		impulse=new_impulse



func kill(immediately=false):
	if !dead:
		dead=true
		$audio_die.play()
		if immediately:
			emit_signal("dead")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="die":
		emit_signal("dead")
