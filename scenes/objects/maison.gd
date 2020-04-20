extends Area2D

signal level_finished(envelope,timer)


func _on_maison_body_entered(body):
	if body is Player:
		emit_signal("level_finished",body.enveloppe,body.timer)
		$audio_win.play()
