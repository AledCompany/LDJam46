extends KinematicBody2D

export var y_impulse = 2000
export var x_impulse = 3000


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TrampolineArea_body_entered(body):
	if body is Player:
		print("le player veut sauter")
		body.velocity += Vector2.UP * y_impulse + body.direction * x_impulse
		print(body.velocity)
	pass # Replace with function body.
