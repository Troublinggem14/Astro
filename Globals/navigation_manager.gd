extends Node
const ASTRO = preload("uid://dabu7exyrms0p")

#Consts of the desired levels you want to travel to
const INSIDE_PLANE = preload("uid://bda7xopcel5iy") 
const MAIN = preload("uid://cy08xdbgpwo0b")

var spawn_door_tag

func go_to_level(level_name, destination_name):
	var scene_to_load
	
	match level_name:
		"InsideShipDoor": #if you are Inside
			scene_to_load = MAIN #You want to go outside
		"OutsideShipDoor": #if you are outside
			scene_to_load = INSIDE_PLANE #You want to go inside
			
	if scene_to_load != null: #if there is a scene to go to
		spawn_door_tag = destination_name 
		get_tree().call_deferred("change_scene_to_packed", scene_to_load)
