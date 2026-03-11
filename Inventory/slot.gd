extends Panel

@onready var icon: TextureRect = $"item icon"
@onready var quantity_label: Label = $quantity


var slot_data: InventorySlotData


func set_slot(data: InventorySlotData):

	slot_data = data

	if data.item:
		icon.texture = data.item.icon
		quantity_label.text = str(data.quantity)
	else:
		icon.texture = null
		quantity_label.text = ""


func _get_drag_data(_position):

	if slot_data == null:
		return
	
	if slot_data.item == null:
		return
	
	var preview = TextureRect.new()
	preview.texture = slot_data.item.icon
	preview.custom_minimum_size = Vector2(32, 32)

	set_drag_preview(preview)

	return self
	
func _can_drop_data(_position, data):

	return data.has_method("swap_slots")
	
func _drop_data(_position, data):

	var from_slot = data

	if from_slot == self:
		return

	swap_slots(from_slot)
	
func swap_slots(other_slot):

	var temp_item = slot_data.item
	var temp_quantity = slot_data.quantity

	slot_data.item = other_slot.slot_data.item
	slot_data.quantity = other_slot.slot_data.quantity

	other_slot.slot_data.item = temp_item
	other_slot.slot_data.quantity = temp_quantity

	InventoryManager.inventory_updated.emit()
