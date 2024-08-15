/mob
	var/list/cast_spell_bar = list()

/mob/proc/get_knowledge_spells()
	var/mob/living/carbon/human/H = usr
	var/assigned_mob = H.mind.assigned_role
	if(assigned_mob == "Chief Steward")
		H.mind?.learned_spells = list(new /spell/targeted/projectile/dumbfire/fireball, new /spell/aoe_turf/blink, new /spell/targeted/equip_item/burning_hand,
		new /spell/targeted/projectile/dumbfire/passage)


/spell/targeted/projectile/dumbfire/fireball
	cast_combo = list(I_HURT, I_HURT, I_HURT)
	cost_charge = 500

/spell/aoe_turf/blink
	cast_combo = list(I_DISARM)
	cost_charge = 100

/spell/targeted/equip_item/burning_hand
	cast_combo = list(I_HURT)
	cost_charge = 200

/spell/targeted/projectile/dumbfire/passage
	cast_combo = list(I_GRAB)
	cost_charge = 200
