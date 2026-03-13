extends Node
const AXE = preload("uid://dh6odjv0umx0a")
const HOE = preload("uid://eiam4qsiouc5")
const PICKAXE = preload("uid://b2ba101rhf7kr")
const WATERINGCAN = preload("uid://berfvd3vcrhdd")
const FISHINGROD = preload("uid://bmsy4hsgu04go")

signal inventory_updated

@export var inventory: InventoryData

func _ready() -> void:
	add_item(AXE, 0)
	add_item(HOE, 0)
	add_item(PICKAXE, 0)
	add_item(WATERINGCAN, 0)
	add_item(FISHINGROD, 0)


func add_item(item: ItemData, amount: int = 1):

	for slot in inventory.slots:

		if slot.item == item and slot.quantity < item.max_stack:
			slot.quantity += amount
			inventory_updated.emit()
			return

	for slot in inventory.slots:

		if slot.item == null:
			slot.item = item
			slot.quantity = amount
			inventory_updated.emit()
			return

func get_selected_item(index):

	var slot = inventory.slots[index]

	if slot and slot.item:
		return slot.item

	return null
	
	
