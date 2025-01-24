extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 0.5)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0)
	
func on_max_damage_reached() -> void:
	queue_free()
	call_deferred("add_log")
	
func add_log() -> void:
	var log_scene_instance = log_scene.instantiate()
	log_scene_instance.global_position = global_position
	get_parent().add_child(log_scene_instance)
	
