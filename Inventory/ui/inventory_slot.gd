extends Panel

@export var slot_index: int
var inventory: InventoryData
var is_hotbar: bool = false

@onready var icon = $Icon
@onready var quantity_label = $Quantity


func setup(inv: InventoryData, index: int, hotbar := false):

	inventory = inv
	slot_index = index
	is_hotbar = hotbar

	update_slot()


func get_slot_data():

	if is_hotbar:
		return inventory.hotbar_slots[slot_index]

	return inventory.inventory_slots[slot_index]


func update_slot():

	var slot = get_slot_data()

	if slot.is_empty():
		icon.texture = null
		quantity_label.text = ""
	else:
		icon.texture = slot.item.icon
		quantity_label.text = str(slot.quantity)


func _gui_input(event):

	if event is InputEventMouseButton and event.pressed:

		if event.button_index == MOUSE_BUTTON_LEFT:

			if is_hotbar:
				inventory.select_hotbar(slot_index)
			else:
				inventory.select_slot(slot_index)


func _get_drag_data(at_position):

	var slot = get_slot_data()

	if slot.is_empty():
		return null

	var preview = TextureRect.new()
	preview.texture = slot.item.icon
	preview.custom_minimum_size = Vector2(40,40)

	set_drag_preview(preview)

	return {
		"from_index": slot_index,
		"from_hotbar": is_hotbar
	}


func _can_drop_data(at_position, data):
	return data is Dictionary and data.has("from_index")


func _drop_data(at_position, data):

	var from_index = data["from_index"]
	var from_hotbar = data["from_hotbar"]

	var from_slot
	var to_slot = get_slot_data()

	if from_hotbar:
		from_slot = inventory.hotbar_slots[from_index]
	else:
		from_slot = inventory.inventory_slots[from_index]

	# STACK
	if not to_slot.is_empty() and to_slot.item == from_slot.item:

		var space = to_slot.item.max_stack - to_slot.quantity
		var amount = min(space, from_slot.quantity)

		to_slot.quantity += amount
		from_slot.quantity -= amount

		if from_slot.quantity <= 0:
			from_slot.clear()

	else:
		var temp_item = to_slot.item
		var temp_qty = to_slot.quantity

		to_slot.item = from_slot.item
		to_slot.quantity = from_slot.quantity

		from_slot.item = temp_item
		from_slot.quantity = temp_qty

	inventory.inventory_updated.emit()
