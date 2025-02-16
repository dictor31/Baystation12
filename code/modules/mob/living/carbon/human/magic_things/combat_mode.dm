/mob/living/carbon/human
	var/combat_mode = 0
	var/crystal

/mob/living/carbon/human/verb/combat_mode()
	set name = "Боевой режим"
	set instant = 1
	set category = "Magic"

	if(combat_mode)
		combat_mode = 0
		to_chat(usr, "Я выдохся")
	else
		combat_mode = 1
		to_chat(usr, "Я готов")

/mob/verb/cast_plus_intent()
	set category = "Magic"
	set hidden = 1

	var/mob/living/carbon/human/H = usr
	if (H.combat_mode)
		if(cast_spell_bar.len < 4)
			switch(a_intent)
				if (I_HELP)
					cast_spell_bar += I_HELP
					to_chat(H, "помощь")
				if (I_DISARM)
					cast_spell_bar += I_DISARM
					to_chat(H, "обезоруживание")
				if (I_GRAB)
					cast_spell_bar += I_GRAB
					to_chat(H, "захват")
				if (I_HURT)
					cast_spell_bar += I_HURT
					to_chat(H, "урон")

/mob/living/carbon/human/verb/create_spell()
	set name = "Наколдовать"
	set category = "Magic"

	var/obj/item/clothing/accessory/magic_crystal/MC

	if(!combat_mode)
		return

	if(!have_crystal())
		to_chat(usr, "У меня нет МОЕЙ прелести")
		cast_spell_bar?.Cut()
		return

	MC = crystal
	for (var/spell/S in mind?.learned_spells)
		if(MC.charge < S.cost_charge)
			to_chat(usr, "У меня недостаточно сил")
			return

		if(S.cast_combo ~= cast_spell_bar)
			S.perform()
			MC.charge -= S.cost_charge
			cast_spell_bar?.Cut()
			return

/mob/living/carbon/human/proc/have_crystal()
	crystal = 0
	var/obj/item/clothing/accessory/magic_crystal/MC

	for(var/obj/item/I in contents)
		if(istype(I, /obj/item/clothing/accessory/magic_crystal))
			MC = I
			if(MC.owner == usr)
				crystal = I
				return TRUE

		else if(istype(I, /obj/item/clothing/under/magic))
			for(var/obj/item/clothing/accessory/A in I.contents)
				if(istype(A, /obj/item/clothing/accessory/magic_crystal))
					MC = A
					if(MC.owner == usr)
						crystal = A
						return TRUE
	return FALSE

/mob/living/carbon/human/verb/delete_cast_spell_bar()
	set name = "Очистить заклинание"
	set category = "Magic"

	cast_spell_bar?.Cut()

/mob/living/carbon/human/verb/remember_spells()
	set name = "Вспомни"
	set category = "Magic"

	for(var/spell/S in mind?.learned_spells)
		var/combo
		var/color
		combo += "<b>[S.name]:</b> " + "<br>"
		for(var/A in S.cast_combo)
			switch(A)
				if(I_HELP)
					color = "green"
					A = "juvare"
				if(I_DISARM)
					color = "#1E90FF"
					A = "pellere"
				if(I_GRAB)
					color = "yellow"
					A = "captis"
				if(I_HURT)
					color = "red"
					A = "noxa"
			combo += "<FONT FACE = Capoon COLOR = [color]><b><i>[A] </i></b></FONT>"
		to_chat(usr, combo)
