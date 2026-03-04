extends Panel

@export var slot_index: int
var inventory: InventoryData

@onready var icon = $Icon
@onready var quantity_label = $Quantity

func setup(inv: InventoryData, index: int):
	inventory = inv
	slot_index = index
	update_slot()

func update_slot():
	var slot = inventory.slots[slot_index]
	
	if slot.is_empty():
		icon.texture = null
		quantity_label.text = ""
	else:
		icon.texture = slot.item.icon
		quantity_label.text = str(slot.quantity)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			inventory.select_slot(slot_index)
