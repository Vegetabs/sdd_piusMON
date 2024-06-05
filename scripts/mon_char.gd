extends CharacterBody2D

@onready var mon_data = []
@onready var mon_sprite = $mon_sprite
@onready var anim = $anim_player
@onready var posx = self.position.x
@onready var posy = self.position.y

func _ready():	
	#attack()
	pass

func setup_mon(mon_info:Array) -> void:
	mon_data = mon_info
	change_mon_texture(1)

func change_mon_texture(mon_id:int) -> void:
	mon_sprite.texture = load(ResourcePaths.get_mon_path(mon_id))

func attack() -> void:
	anim.play("attack")
	var tween = get_tree().create_tween()
	tween.set_ease(2)
	tween.tween_property(self,"position",Vector2(posx+200,posy),1)

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "attack":
		var tween = get_tree().create_tween()
		tween.set_ease(2)
		tween.tween_property(self,"position",Vector2(posx,posy),0.5)
