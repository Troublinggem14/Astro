extends Node
class_name InventoryData

signal inventory_updated
signal item_selected(slot_data)

@export var size: int = 20

var slots: Array[InventorySlotData] = []

func _enter_tree():
	initialize_slots()

func initialize_slots():
	if not slots.is_empty():
		return
	
	for i in size:
		slots.append(InventorySlotData.new())

func add_item(item: ItemData, amount: int = 1) -> bool:
	# Try stacking first
	for slot in slots:
		if slot.item and slot.item.id == item.id and slot.quantity < item.max_stack:
			var space_left = item.max_stack - slot.quantity
			var add_amount = min(space_left, amount)
			slot.quantity += add_amount
			amount -= add_amount
			if amount <= 0:
				inventory_updated.emit()
				return true
	
	# Then find empty slots
	for slot in slots:
		if slot.is_empty():
			slot.item = item
			slot.quantity = min(amount, item.max_stack)
			amount -= slot.quantity
			if amount <= 0:
				inventory_updated.emit()
				return true
	
	inventory_updated.emit()
	return false

func remove_from_slot(index: int, amount: int = 1):
	var slot = slots[index]
	if slot.is_empty():
		return
	
	slot.quantity -= amount
	if slot.quantity <= 0:
		slot.item = null
		slot.quantity = 0
	
	inventory_updated.emit()

func select_slot(index: int):
	item_selected.emit(slots[index])
	
#---------SAVING_DATA---------#
func save_inventory():
	var save_data = []
	
	for slot in slots:
		if slot.is_empty():
			save_data.append(null)
		else:
			save_data.append({
				"id": slot.item.id,
				"quantity": slot.quantity
			})
	
	var file = FileAccess.open("user://inventory.save", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))

func load_inventory():
	if not FileAccess.file_exists("user://inventory.save"):
		return
	
	var file = FileAccess.open("user://inventory.save", FileAccess.READ)
	var content = file.get_as_text()
	var save_data = JSON.parse_string(content)
	
	for i in save_data.size():
		var data = save_data[i]
		if data == null:
			continue
		
		var item = load("res://inventory/resources/%s.tres" % data["id"])
		slots[i].item = item
		slots[i].quantity = data["quantity"]
	
	inventory_updated.emit()
