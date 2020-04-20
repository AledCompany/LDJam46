extends Area2D



func _on_Envelope_body_entered(body):
	if body is Player:
		body.enveloppe=true
		$AnimationPlayer.play("destroy")
