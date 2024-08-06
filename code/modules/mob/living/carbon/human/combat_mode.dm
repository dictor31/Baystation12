/mob
	var/combat_mode = 0
	var/list/cast_spell = list()
	var/list/all_spells = list()
	var/list/knowledge_spells = list()


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
		switch(a_intent)
			if (I_HELP)
				cast_spell += I_HELP
				to_chat(H, "помощь")
			if (I_DISARM)
				cast_spell += I_DISARM
				to_chat(H, "обезоруживание")
			if (I_GRAB)
				cast_spell += I_GRAB
				to_chat(H, "захват")
			if (I_HURT)
				cast_spell += I_HURT
				to_chat(H, "урон")

/mob/living/carbon/human/verb/create_spell()
	set name = "Наколдовать"
	set category = "IC"

	var/mob/living/carbon/human/H = usr
	if(H.combat_mode)
		if(list(I_HURT, I_GRAB) ~= cast_spell)
			var/spell/S = new /spell/targeted/projectile/dumbfire/fireball
			S.perform()
		cast_spell?.Cut()
