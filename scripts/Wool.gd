extends KinematicBody2D

var gravity = 9.81
var velocity = Vector2.ZERO

var x_impulse = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_collide(velocity)
	pass

func _on_DetectionArea_body_entered(body):
	if body is Player:
		body.set_impulse(body.direction * x_impulse)
		body.get_node("audio_dash").play()
	pass # Replace with function body.
