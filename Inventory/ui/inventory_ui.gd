extends Control

@export var inventory: InventoryData
@onready var grid = $GridContainer
@onready var info_panel = $InfoPanel
@onready var name_label = $InfoPanel/Name
@onready var desc_label = $InfoPanel/Description

func _ready():
	inventory.inventory_updated.connect(update_ui)
	inventory.item_selected.connect(show_item_info)
	
	for i in inventory.size:
		var slot_scene = preload("res://inventory/ui/inventory_slot.tscn")
		var slot_instance = slot_scene.instantiate()
		grid.add_child(slot_instance)
		slot_instance.setup(inventory, i)
	
	update_ui()

func update_ui():
	for i in grid.get_child_count():
		grid.get_child(i).update_slot()

func show_item_info(slot_data):
	if slot_data.is_empty():
		info_panel.visible = false
		return
	
	info_panel.visible = true
	name_label.text = slot_data.item.display_name
	desc_label.text = slot_data.item.description
