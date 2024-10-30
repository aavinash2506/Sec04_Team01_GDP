extends RigidBody2D

# --------- VARIABLES ---------- #
var positionA = Vector2(0, 0)
var positionC = Vector2(-400, -200)
var positionB = Vector2(-652, 44)
var t = 0.0
var level = 0


@onready var handled = false


					#This list of chemical compounds can be expanded if need be.
					#To add more, simply create a string array of size 2, containing the compound itself,
					# as well as whether it is a  base, acid, neutral or both
					
@onready var formula = $FormulaLabel
@onready var projectile_sprite = $Sprite2D
@onready var projectile = self
@onready var acidExplosion = $Explosion/Acid
@onready var baseExplosion = $Explosion/Base
@onready var acidParticles = $Explosion/AcidParticles
@onready var baseParticles = $Explosion/BaseParticles
@onready var neutralParticles = $Explosion/NeutralParticles
@onready var shared_data = get_node("/root/Global")

var selection = 0
# --------- FUNCTIONS ---------- #
func _ready():
	
	#print("enemy.projectile.projectile---- "+str(level))
	projectile_sprite.material.set_shader_parameter("active", false)
	acidParticles.emitting = false
	baseParticles.emitting = false
	neutralParticles.emitting = false
	acidExplosion.disabled
	baseExplosion.disabled
	#var selection = randi_range(0, compoundArray.size() - 1)
	selection = randi_range(0, shared_data.compoundArray.size() - 1)
	#print("level:: compoundArray[selection][0]: "+str(shared_data.compoundArray[selection][0])+
	#"  compoundArray[selection][1]: "+str(shared_data.compoundArray[selection][1])+
	#"  shared_lvl1.total_qus_lvl_1: "+str(shared_data.total_qus_lvl_1))
	add_to_group(shared_data.compoundArray[selection][1])
	formula.text = "[center]" + shared_data.compoundArray[selection][0] + "[/center]"
	
	

func _physics_process(delta):
	#print("delta: "+str(delta) +" shared_data.duration: "+str(shared_data.duration))
	rotation = 0.00
	t += delta / shared_data.duration
	var q0 = positionA.lerp(positionC, min(t, 1.0))
	var q1 = positionC.lerp(positionB, min(t, 1.0))
	self.position = q0.lerp(q1, min(t, 1.0))


	#print(
		#"formula--> "+ (formula.text) +
		#"comArr--> "+ str(compoundArray[0][0]) +
	#"  acid: "+str(is_in_group("Acid")) + 
	#" base: "+str(is_in_group("Base"))+
	#"  both: "+str(is_in_group("Both"))+
	#"  Nutral: " +str(is_in_group("Neutral")) +
	#"  level: "+str(level))
	#"  delta: "+str(delta))
	#print("enemy_projectile::self.position: "+str(self.position)+
	#"  positionB: "+str(positionB ) +"    (self.position == positionB): "+str((self.position == positionB)))
	if (self.position == positionB):
		
		#print("enemy_projectile::self.position: "+str(self.position)+
	#"  positionB: "+str(positionB ) +"    (self.position == positionB): "+str((self.position == positionB)))
	
		if not handled:
			handled = true
			#if (level == 1):
				#if is_in_group("Acid") && compoundArray[selection][1] == "Acid":
					#acidParticles.emitting=true
					#await get_tree().create_timer(0.1).timeout
					#shared_data.duration = shared_data.duration - .2
					#acidExplosion.disabled=false
					#
					#
				#else:
					#print("enemy..ELSEEEEEEEE")
					#baseParticles.emitting=true
					#await get_tree().create_timer(0.1).timeout
					#baseExplosion.disabled = true
					##neutralParticles.emitting = true
					
				
					
			if is_in_group("Acid"):
				acidParticles.emitting=true
				await get_tree().create_timer(0.1).timeout
				shared_data.duration = 3.0
				acidExplosion.disabled=false
			#
			if is_in_group("Base"):
				baseParticles.emitting=true
				await get_tree().create_timer(0.1).timeout
				if (level != 1):
					shared_data.duration = 3.0 - .2
				baseExplosion.disabled=false
			#
			if is_in_group("Both"):
				if (level != 1):
					shared_data.duration = 3.0 - .25
				neutralParticles.emitting=true
				baseExplosion.disabled=false
			
			if is_in_group("Neutral"):
				if (level != 1):
					shared_data.duration = 3.0 - .3
				neutralParticles.emitting=true
				baseExplosion.disabled=false
				
			await get_tree().create_timer(0.5).timeout
			$"..".projectile_finished.emit()
		formula.hide()
		disable()
		await get_tree().create_timer(0.5).timeout
		acidExplosion.disabled=true
		baseExplosion.disabled=true
		await get_tree().create_timer(3).timeout
		queue_free()
		
	
func _on_explosion_body_entered(body):
	#print("Body entered: " + str(body))
#	set minimum value else speed too fast
	if (shared_data.duration < .8):
		shared_data.duration = .8
	
	#print("enemy_projectile.._on_explosion_body_entered: " + str(body)+
	#"  shared_data.duration: "+str(shared_data.duration))
	body.ouch(shared_data.compoundArray[selection][1], level)
	#body.ouch()
	
func disable():
	projectile_sprite.hide()
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	
func ouch():
	print("enemy_projectile..ouch")
	projectile_sprite.material.set_shader_parameter("active", true)
	set_physics_process(false)
	await get_tree().create_timer(0.1).timeout
	set_physics_process(true)
	queue_free()
	
	
	
