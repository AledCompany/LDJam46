extends Node

var tween_out:Tween
var tween_in:Tween
var player1:AudioStreamPlayer
var player2:AudioStreamPlayer
var queue:Array
var tween_trans=Tween.TRANS_LINEAR
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	tween_out=Tween.new()
	tween_in=Tween.new()
	player1=AudioStreamPlayer.new()
	player2=AudioStreamPlayer.new()
	tween_out.connect("tween_completed",self,"_on_TweenOut_tween_completed")
	add_child(tween_out)
	add_child(tween_in) 
	add_child(player1)
	add_child(player2)

func fade(stream,time_in,time_out,sync_offset=false):
	var canplay=false
	
	if !player1.is_playing():
		player1.stream=stream
		var pos=0.0
		if sync_offset:
			if player2.is_playing():
				pos=fmod(player2.get_playback_position(),player1.stream.get_length())
		fade_in(player1,time_in,pos)
		canplay=true
	else:
		fade_out(player1,time_out)
	if !player2.is_playing():
		if !canplay:
			player2.stream=stream
			var pos=0.0
			if sync_offset:
				if player1.is_playing():
					pos=fmod(player1.get_playback_position(),player2.stream.get_length())
			fade_in(player2,time_in,pos)
			canplay=true
	elif canplay:
		fade_out(player2,time_out)
	if !canplay:
		queue.push_back({"stream":stream,"time_in":time_in,"time_out":time_out,"sync_offset":sync_offset})
func fade_out(stream_player,transition_duration=1.0):
	
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, tween_trans, Tween.EASE_IN, 0)
	tween_out.start()
	
func fade_in(stream_player,transition_duration=1.0,from_position=0.0):
	stream_player.set_volume_db(-80)
	tween_in.interpolate_property(stream_player, "volume_db", -80, 0, transition_duration, tween_trans, Tween.EASE_IN, 0)
	tween_in.start()
	stream_player.play(from_position)

func stop(time_out):
	if player1.is_playing():
		fade_out(player1,time_out)
	if player2.is_playing():
		fade_out(player2,time_out)
func _on_TweenOut_tween_completed(object, key):
	# stop the music -- otherwise it continues to run at silent volume
	object.stop()
	if queue.size()>0:
		var tmp=queue.pop_front()
		fade(tmp.stream,tmp.time_in,tmp.time_out,tmp.sync_offset)
