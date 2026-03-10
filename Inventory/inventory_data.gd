extends Node
class_name InventoryData

signal inventory_updated
signal item_selected(slot_data)

@export var size: int = 20
@export var hotbar_size: int = 8

var inventory_slots: Array[InventorySlotData] = []
var hotbar_slots: Array[InventorySlotData] = []

var selected_hotbar_slot: int = 0


func _enter_tree():
	initialize_slots()


func initialize_slots():

	if not inventory_slots.is_empty():
		return

	for i in range(size):
		inventory_slots.append(InventorySlotData.new())

	for i in range(hotbar_size):
		hotbar_slots.append(InventorySlotData.new())
		

func _process(delta: float) -> void:
	print(hotbar_slots)

# -----------------------------
# ADD ITEM (Inventory Only)
# -----------------------------
func add_item(item: ItemData, amount: int = 1) -> bool:

	# Try stacking first
	for slot in inventory_slots:
		if slot.item and slot.item.id == item.id and slot.quantity < item.max_stack:

			var space_left = item.max_stack - slot.quantity
			var add_amount = min(space_left, amount)

			slot.quantity += add_amount
			amount -= add_amount

			if amount <= 0:
				inventory_updated.emit()
				return true


	# Then find empty slot
	for slot in inventory_slots:
		if slot.is_empty():

			slot.item = item
			slot.quantity = min(amount, item.max_stack)

			amount -= slot.quantity

			if amount <= 0:
				inventory_updated.emit()
				return true

	inventory_updated.emit()
	return false


# -----------------------------
# INVENTORY SLOT CLICK
# -----------------------------
func select_slot(index: int):

	if index < 0 or index >= inventory_slots.size():
		return

	item_selected.emit(inventory_slots[index])


# -----------------------------
# HOTBAR SELECT
# -----------------------------
func select_hotbar(index: int):

	if index < 0 or index >= hotbar_size:
		return

	selected_hotbar_slot = index
	item_selected.emit(hotbar_slots[index])

	inventory_updated.emit()


func scroll_hotbar(direction: int):

	selected_hotbar_slot += direction

	if selected_hotbar_slot < 0:
		selected_hotbar_slot = hotbar_size - 1

	if selected_hotbar_slot >= hotbar_size:
		selected_hotbar_slot = 0

	item_selected.emit(hotbar_slots[selected_hotbar_slot])
	inventory_updated.emit()


# -----------------------------
# GET CURRENT ITEM / TOOL
# -----------------------------
func get_selected_item():

	var slot = hotbar_slots[selected_hotbar_slot]

	if slot.is_empty():
		return null

	return slot.item


func get_selected_tool():

	var slot = hotbar_slots[selected_hotbar_slot]

	if slot.is_empty():
		return data_types.Tools.None

	return slot.item.tool_type


# -----------------------------
# SAVE INVENTORY
# -----------------------------
func save_inventory():

	var save_data = []

	for slot in inventory_slots:

		if slot.is_empty():
			save_data.append(null)
		else:
			save_data.append({
				"id": slot.item.id,
				"quantity": slot.quantity
			})

	var file = FileAccess.open("user://inventory.save", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))


# -----------------------------
# LOAD INVENTORY
# -----------------------------
func load_inventory():

	if not FileAccess.file_exists("user://inventory.save"):
		return

	var file = FileAccess.open("user://inventory.save", FileAccess.READ)
	var content = file.get_as_text()

	var save_data = JSON.parse_string(content)

	for i in range(save_data.size()):

		var data = save_data[i]

		if data == null:
			continue

		var path = "res://inventory/resources/%s.tres" % data["id"]

		if ResourceLoader.exists(path):

			var item = load(path)

			inventory_slots[i].item = item
			inventory_slots[i].quantity = data["quantity"]

	inventory_updated.emit()
