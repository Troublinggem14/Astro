extends Node

var toggle_inventory_func: bool = true
var toggle_pausemenu_func: bool = true


@export var inventory: CanvasLayer
@export var pause_menu: Node2D



func _input(event: InputEvent) -> void:

	if event.is_action_pressed("inventory"):
		toggle_inventory()

	if event.is_action_pressed("pause"):
		toggle_pause()


func toggle_pause():
	if toggle_pausemenu_func == true:
		if pause_menu == null:
			return

		pause_menu.visible = !pause_menu.visible
		toggle_inventory_func = !toggle_inventory_func
		get_tree().paused = pause_menu.visible


func toggle_inventory():
	if toggle_inventory_func == true:
		if inventory == null:
			return

		inventory.visible = !inventory.visible
		toggle_pausemenu_func = !toggle_pausemenu_func
		get_tree().paused = inventory.visible
		
