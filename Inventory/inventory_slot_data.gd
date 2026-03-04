extends Resource
class_name InventorySlotData

@export var item: ItemData
@export var quantity: int = 0

func is_empty() -> bool:
	return item == null or quantity <= 0

func can_stack_with(other: InventorySlotData) -> bool:
	if is_empty() or other.is_empty():
		return false
	return item.id == other.item.id and quantity < item.max_stack
