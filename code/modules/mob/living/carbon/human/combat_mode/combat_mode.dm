/mob
	var/combat_mode = 0

/mob/living/carbon/human/verb/combat_mode()
	set name = "Боевой режим"
	set instant = 1
	set category = "IC"
	var/mob/living/carbon/human/H = usr
	H.toggle_combat_mode()

/mob/living/carbon/human/verb/toggle_combat_mode()
	set hidden = 1
	var/mob/living/carbon/human/H = usr
	if(H.combat_mode)
		H.combat_mode = 0
		to_chat(H, "Я выдохся")
//		H.combat_mode_icon.icon_state = "cmbt0"
//		H << 'sound/webbers/ui_toggleoff.ogg'
//		H << sound(null, repeat = 0, wait = 0, volume = src?.client?.prefs?.music_volume, channel = 12)
//		var/list/sounds_list = H.client.SoundQuery()
//		for(var/playing_sound in sounds_list)
//			var/sound/found = playing_sound
//			if(found.channel == 9)
//				found.volume = src?.client?.prefs?.music_volume
//				found.status = SOUND_UPDATE
//				H << found
//		if(src.wear_mask)
//			if(istype(wear_mask,/obj/item/clothing/mask/gas/church))
//				var/obj/item/clothing/mask/gas/church/G = wear_mask
//				G.icon_state = G.off_state
//				G.item_state = G.off_state
//				H.update_inv_head()
//				H.update_inv_wear_mask()
	else
		H.combat_mode = 1
		get_knowledge_spells()
		to_chat(H, "Я готов трахать")
//		H.combat_mode_icon.icon_state = "cmbt1"
//		H << 'sound/webbers/ui_toggle.ogg'
//		var/area/A = get_area(src)
//		if(src.wear_mask)
//			if(istype(wear_mask,/obj/item/clothing/mask/gas/church))
//				var/obj/item/clothing/mask/gas/church/G = wear_mask
//				G.icon_state = G.on_state
//				G.item_state = G.on_state
//				H.update_inv_head()
//				H.update_inv_wear_mask()


//		var/list/sounds_list = H.client.SoundQuery()
//		for(var/playing_sound in sounds_list)
//			var/sound/found = playing_sound
//			if(found.channel == 9)
//				found.volume = 0
//				found.status = SOUND_UPDATE
//				H << found

//		var/sound/S = sound(pick('sound/fortress_suspense/suspense1.ogg','sound/fortress_suspense/suspense2.ogg','sound/fortress_suspense/suspense3.ogg','sound/fortress_suspense/suspense4.ogg','sound/fortress_suspense/suspense5.ogg','sound/fortress_suspense/suspense6.ogg','sound/fortress_suspense/suspense7.ogg','sound/fortress_suspense/suspense8.ogg'), repeat = 1, wait = 0, volume = src?.client?.prefs?.music_volume, channel = 12)
//		S.environment = A.sound_env
/mob/verb/cast_plus_intent()
	set category = "IC"
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
	set category = "IC"

	var/mob/living/carbon/human/H = usr
	if(H.combat_mode)
		for (var/spell/S in H.mind?.learned_spells)
			if(S.cast_combo ~= cast_spell_bar)
				S.perform()
				break
		cast_spell_bar?.Cut()

/mob/living/carbon/human/verb/delete_cast_spell_bar()
	set name = "Очистить заклинание"
	set category = "IC"

	cast_spell_bar?.Cut()

/mob/living/carbon/human/verb/remember_spells()
	set name = "Вспомни"
	set category = "IC"

	var/mob/living/carbon/human/H = usr
	for(var/spell/S in H.mind?.learned_spells)
		var/combo
		var/color
		combo += "<b>[S.name]:</b> " + "<br>"
		for(var/A in S.cast_combo)
			switch(A)
				if(I_HELP)
					color = "green"
					A = "juvare"
				if(I_DISARM)
					color = "blue"
					A = "pellere"
				if(I_GRAB)
					color = "yellow"
					A = "captis"
				if(I_HURT)
					color = "red"
					A = "noxa"
			combo += "<FONT COLOR = [color]><b><i>>[A] </i></b></FONT>"
		to_chat(H, combo)
