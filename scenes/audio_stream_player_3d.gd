extends AudioStreamPlayer3D


var ambience = preload("res://assets/sound/night-ambience-59071.mp3")
var hoot = preload("res://assets/sound/owl-hooting-223549.mp3")

func _process(time) -> void:
	if !self.is_playing():
		self.stream = ambience
		self.play()
	if !self.is_playing():
		self.stream = hoot
		self.play()
