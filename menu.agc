// funcionamento do cursor
logicaMenu:

	if (flagMenu_info)
		SetSpriteFrame(spr_menubg, 2)
	else
		SetSpriteFrame(spr_menubg, 1)
	endif

	SetSpritePosition(spr_pointer, GetPointerX(), GetPointerY())
	
	if (GetSpriteCollision(spr_pointer, spr_botao_info))
		SetSpriteFrame(spr_botao_info, 2)
		for i = 0 to 3
			Print("")
		next i
		Print("	CRÉDITOS")
		if GetPointerReleased()
			flagMenu_info = NOT flagMenu_info
			PlaySound(sfx_toggle, sfx_vol)
		endif
		
	elseif (GetSpriteCollision(spr_pointer, spr_botao_music)) 
		SetSpriteFrame(spr_botao_music, 4 - (2*flagToggleMusic))
		for i = 0 to 3
			Print("")
		next i
		Print("	LIGAR/DESLIGAR MÚSICA")
		if GetPointerReleased()
			flagToggleMusic = NOT flagToggleMusic
			PlaySound(sfx_toggle, sfx_vol)
		endif
		
	elseif (GetSpriteCollision(spr_pointer, spr_botao_sfx)) 
		for i = 0 to 3
			Print("")
		next i
		Print("	LIGAR/DESLIGAR EFEITOS SONOROS")
		SetSpriteFrame(spr_botao_sfx, 4 - (2*flagToggleSfx))
		if GetPointerReleased()
			flagToggleSfx = NOT flagToggleSfx
			PlaySound(sfx_toggle, sfx_vol)
		endif
		
	elseif (GetSpriteCollision(spr_pointer, spr_botao_zen)) 
		for i = 0 to 3
			Print("")
		next i
		Print("	LIGAR/DESLIGAR MODO ZEN")
		for i = 0 to 4
			Print("")
		next i
		Print("	* Modo relaxante")
		Print("	* Dificuldade é significantemente reduzida.")
		SetSpriteFrame(spr_botao_zen, 4 - (2*flagModoZen))
		if GetPointerReleased()
			flagModoZen = NOT flagModoZen
			PlaySound(sfx_toggle, sfx_vol)
		endif
		
	else
		SetSpriteFrame(spr_botao_info, 1)
		SetSpriteFrame(spr_botao_music, 3 - (2*flagToggleMusic))
		SetSpriteFrame(spr_botao_sfx, 3 - (2*flagToggleSfx))
		SetSpriteFrame(spr_botao_zen, 3 - (2*flagModoZen))
		
		if (GetRawKeyReleased(KEY_SPACE)) OR (GetRawKeyReleased(KEY_UP)) OR (GetPointerReleased())
			PlaySound(sfx_toggle, sfx_vol)
			mudaTela("fase")
		endif
	endif

return

// menu pausa
pausarJogo:
	flagPausado = 1
	flagPause_quit = 0
	counterEsc = 0
	
	PlaySound(sfx_pause, sfx_vol * 2)
	for i = 0 to MAX_MUSICAS-1
		SetMusicFileVolume(music[i], music_vol / 2)
	next i
	
	while (flagPausado)
		sync()
		
		SetSpriteVisible(spr_pause, 1)
		
		// segurar esc para ir pro menu
		if (GetRawKeyState(KEY_ESCAPE)) 
			counterEsc = counterEsc + 1
		endif
		
		if (counterEsc > 20)
			flagPausado = 0
			flagPause_quit = 1
		endif
		
		// inputs para despausar
		if GetRawKeyReleased(KEY_ESCAPE) then flagPausado = 0
		
	endwhile
	
	SetSpriteVisible(spr_pause, 0)
	//SetMusicFileVolume(music[0], music_vol)
	if (flagPause_quit) then mudaTela("menu")

return


// efeito da trilha menu
atualizarTrilha_menu:
	
	for i = 0 to 1
		x_atual = GetSpriteX(spr_scroller[i])
		x_atual = x_atual + 4
		if (x_atual >= offset) then x_atual = -offset
		
		SetSpriteX(spr_scroller[i], x_atual)
		
	next i

return
