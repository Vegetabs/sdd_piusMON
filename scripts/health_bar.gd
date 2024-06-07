extends TextureProgressBar


var health := 0

func _ready():
	#self.value = health
	pass

func change_health(arr:Array,dmg:int) -> void: 
	var max := 100
	var mon_max = arr[1][2]*5
	var mon_cur = arr[2]
	print("tttt")
	print(mon_cur)
	print(mon_max)
	var hp_ratio : float = float(mon_cur)/float(mon_max)
	print(hp_ratio)
	print(dmg)
	health = int(float(max)*hp_ratio) - int(float(dmg)*(float(max)/float(mon_max)))
	print(health)
	if health < 0:
		health = 0
	self.value = health

func change_max_health(val:int) -> void:
	health = val
	self.max_value = val
	self.value = val
