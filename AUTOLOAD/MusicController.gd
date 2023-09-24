extends Node

var mus_intro = load("res://Music/Intro.mp3")
var mus_area_01 = load("res://Music/Area01.mp3")
var mus_eerie = load("res://Music/Eerie.mp3")


func play_music():
	
	$MusicPlayer.stream = mus_intro
	$MusicPlayer.play()
	
	# Start stage 01 theme after a  bit of time
	
	var t = Timer.new()
	t.set_wait_time(17)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await(t.timeout)
	
	$MusicPlayerAlt.stream = mus_area_01
	$MusicPlayerAlt.play()
	
	t.queue_free()
	
	

