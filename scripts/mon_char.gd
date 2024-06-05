extends CharacterBody2D

@onready var mon_data = []
@onready var mon_sprite = $mon_sprite
@onready var anim = $anim_player
@onready var posx = self.position.x
@onready var posy = self.position.y
var mon_cache := []

func _ready():	
	pass

func setup_mon(mon_info:Array) -> void:
	mon_data = mon_info
	change_mon_texture(mon_data[0])

func change_mon_texture(mon_id:int) -> void:
	mon_sprite.texture = load(ResourcePaths.get_mon_path(mon_id))

func attack() -> void:
	anim.play("attack")
	var tween = get_tree().create_tween()
	tween.set_ease(2)
	tween.tween_property(self,"position",Vector2(posx+200,posy),1)
	tween.tween_property(self,"position",Vector2(posx,posy),0.5)

func swap(new_mon:Array) -> void:
	mon_cache = new_mon
	anim.play("swap")

func hit(dmg:int) -> void:
	if _set_health(dmg) == true:
		death()
	else:
		anim.play("hit")

func death():
	anim.play("death")
	pass

func _set_health(val:int) -> bool:
	if mon_data[2]-val <= 0:
		mon_data[2] = 0
		return true
	else:
		mon_data[2] -= val
		return false

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "attack":
		pass
	elif anim_name == "swap":
		setup_mon(mon_cache)
		mon_cache = []
