extends Control

@export var inventory: InventoryData

@onready var bar = $Panel/HBoxContainer

var slot_scene = preload("res://inventory/ui/inventory_slot.tscn")

func _ready():

	inventory.inventory_updated.connect(update_hotbar)

	create_hotbar_slots()
	update_hotbar()


func create_hotbar_slots():

	for i in range(inventory.hotbar_size):

		var slot = slot_scene.instantiate()

		bar.add_child(slot)

		slot.setup(inventory, i, true)


func update_hotbar():

	for i in range(bar.get_child_count()):

		var slot = bar.get_child(i)

		slot.update_slot()

		# Highlight selected slot
		if i == inventory.selected_hotbar_slot:
			slot.modulate = Color(1,1,1,1)
		else:
			slot.modulate = Color(0.7,0.7,0.7,1)


func _input(event):

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			inventory.scroll_hotbar(-1)

		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			inventory.scroll_hotbar(1)

	if event is InputEventKey and event.pressed:

		if event.keycode >= KEY_1 and event.keycode <= KEY_8:

			var index = event.keycode - KEY_1

			inventory.select_hotbar(index)
