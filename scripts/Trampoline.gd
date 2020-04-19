extends KinematicBody2D

class_name Trampoline

var gravity = 9.81
export var y_impulse = 2500
export var x_impulse = 200

var velocity = Vector2.ZERO


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_collide(velocity)
	pass


func _on_TrampolineArea_body_entered(body):
	if body is Player:
		$Sprite.frame = 0
		$Sprite.play("spring")
		body.velocity += Vector2.UP * y_impulse + body.direction * x_impulse
		print(body.velocity)
		body.setAnimationJumping()
	pass # Replace with function body.
