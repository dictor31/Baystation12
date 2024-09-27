GLOBAL_DATUM_INIT(alternates, /datum/antagonist/alternate, new)

/datum/antagonist/alternate
	id = MODE_TRAITOR
	welcome_text = "Мы стали чем-то другим..."
	antag_text = "Помоги другим сделать для этого места нечто большее"
	role_text = "Alternate"
	role_text_plural = "Alternates"
	antaghud_indicator = "hud_traitor"
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
