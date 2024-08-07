/mob
	var/list/cast_spell_bar = list()
	var/list/knowledge_spells = list()

/mob/proc/get_knowledge_spells()
	var/mob/living/carbon/human/H = usr
	var/assigned_mob = H.mind.assigned_role
	if(assigned_mob == "Chief Steward")
		knowledge_spells = list(/spell/targeted/projectile/dumbfire/fireball, /spell/aoe_turf/blink)
