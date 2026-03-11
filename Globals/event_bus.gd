extends Node
@warning_ignore_start("unused_signal") #⬇️ removes the debug to all of these signals ⬇️


signal spawn_log(position: Vector2)
signal spawn_rock(position: Vector2)
signal rock_hit
signal tree_hit

signal Deplete_oxygen_signal(amount:int)
signal die()
