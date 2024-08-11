/mob
	var/list/cast_spell_bar = list()

/mob/proc/get_knowledge_spells()
	var/mob/living/carbon/human/H = usr
	var/assigned_mob = H.mind.assigned_role
	if(assigned_mob == "Chief Steward")
		H.mind?.learned_spells = list(new /spell/targeted/projectile/dumbfire/fireball, new /spell/aoe_turf/blink)


/spell/targeted/projectile/dumbfire/fireball
	cast_combo = list(I_HURT, I_HURT, I_HURT)

/spell/aoe_turf/blink
	cast_combo = list(I_DISARM)
