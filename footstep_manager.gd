extends Node

var current_surface = "Grass"

const footstep_sounds = {
	"Grass": [
		preload("res://Assets/Audio/Sound Effects/Footsteps/Grass/Footstep_Grass_Fast_1.wav"),
		preload("res://Assets/Audio/Sound Effects/Footsteps/Grass/Footstep_Grass_Fast_2.wav"),
		preload("res://Assets/Audio/Sound Effects/Footsteps/Grass/Footstep_Grass_Fast_3.wav"),
		preload("res://Assets/Audio/Sound Effects/Footsteps/Grass/Footstep_Grass_Fast_4.wav"),
		preload("res://Assets/Audio/Sound Effects/Footsteps/Grass/Footstep_Grass_Fast_5.wav"),
		preload("res://Assets/Audio/Sound Effects/Footsteps/Grass/Footstep_Grass_Fast_6.wav"),
	],

	"Dirt": [
		preload("res://Assets/Audio/Sound Effects/Footsteps/Dirt and Sand/Dirt Footstep 1.mp3"),
		preload("res://Assets/Audio/Sound Effects/Footsteps/Dirt and Sand/Dirt Footstep 2.mp3"),
		preload("res://Assets/Audio/Sound Effects/Footsteps/Dirt and Sand/Dirt Footstep 3.mp3")
	]
}

@onready var audio_player = AudioStreamPlayer2D.new()

func _ready():
	add_child(audio_player)

func set_surface(surface:String):
	current_surface = surface

func play_step(position:Vector2):

	if !footstep_sounds.has(current_surface):
		return
	audio_player.global_position = position
	audio_player.stream = footstep_sounds[current_surface].pick_random()
	audio_player.play()
