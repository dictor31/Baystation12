/mob
	var/list/cast_spell_bar = list()

/mob/proc/get_knowledge_spells()
	var/mob/living/carbon/human/H = usr
	var/assigned_mob = H.mind.assigned_role
	switch(assigned_mob)
		if("Высший сборщик")
			H.mind?.learned_spells = list(
			new /spell/targeted/projectile/dumbfire/fireball,
			new /spell/aoe_turf/blink,
			new /spell/targeted/projectile/dumbfire/passage,
			new /spell/aoe_turf/conjure/forcewall,
			new /spell/aoe_turf/smoke,
			new /spell/invisibility,
			new /spell/targeted/shapeshift
			)


/spell/targeted/projectile/dumbfire/fireball
	name = "Огненный шар"
	cast_combo = list(I_HURT, I_HURT)
	cost_charge = 500

/spell/aoe_turf/blink
	name = "Скачок"
	cast_combo = list(I_DISARM)
	cost_charge = 100

/spell/targeted/projectile/dumbfire/passage
	name = "Прыжок"
	cast_combo = list(I_GRAB)
	cost_charge = 200

/spell/aoe_turf/conjure/forcewall
	name = "Барьер"
	cast_combo = list(I_HELP)

/spell/aoe_turf/smoke
	name = "Дымовая завеса"
	cast_combo = list(I_HELP, I_HELP)

/spell/invisibility
	name = "Невидимость"
	cast_combo = list(I_DISARM, I_DISARM)

/spell/targeted/shapeshift
	cast_combo = list(I_HURT)
