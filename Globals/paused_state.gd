extends Node

var toggle_inventory_func: bool = true
var toggle_pausemenu_func: bool = true
var toggle_dev_tool_func: bool = true


@export var inventory: Control
@export var pause_menu: Node2D
@export var dev_tool: CanvasLayer



func _input(event: InputEvent) -> void:

	if event.is_action_pressed("inventory"):
		toggle_inventory()

	if event.is_action_pressed("pause"):
		toggle_pause()

	if event.is_action_pressed("DevTool"):
		toggle_dev_tool()

func toggle_pause():
	if toggle_pausemenu_func == true:
		if pause_menu == null:
			return

		pause_menu.visible = !pause_menu.visible
		toggle_inventory_func = !toggle_inventory_func
		toggle_dev_tool_func = !toggle_dev_tool_func
		get_tree().paused = pause_menu.visible


func toggle_inventory():
	if toggle_inventory_func == true:
		if inventory == null:
			return

		inventory.visible = !inventory.visible
		toggle_pausemenu_func = !toggle_pausemenu_func
		toggle_dev_tool_func = !toggle_dev_tool_func
		get_tree().paused = inventory.visible
		

func toggle_dev_tool():
	if toggle_dev_tool_func == true: #if the other menus arent being used
		if dev_tool == null: #if the export is not filled in, return else-
			return
			
		dev_tool.visible = !dev_tool.visible #Toggle the visibility of the dev tool
		
		toggle_pausemenu_func = !toggle_pausemenu_func #make it so I cant use the other menus
		toggle_inventory_func = !toggle_inventory_func #make it so I cant use the other menus

		get_tree().paused = dev_tool.visible #pause the dev_tool
