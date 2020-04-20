extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_Detection_body_entered(body):
	if body is Player:
		body.enveloppe=true
		destroy()

func destroy():
	pass
