
loaderInicial:		// LOADER INICIAL (IMPLEMENTAR COISAS DEPOIS !! !)
	// reseta recorde
	flagModoZen = 0
	flagHouvePrimeiraMorte = 0
	recorde_normal = 0
	recorde_zen = 0
	
	flagToggleMusic = 1
	flagToggleSfx = 1
	
	// carrega musicas
	for i = 0 to MAX_MUSICAS-1
		music[i] = LoadMusic("music/mus" + str(i+1) + ".mp3")
		SetMusicFileVolume(music[i], music_vol)
		
	next i
	music_menu = LoadMusic("music/mus_menu.mp3")
	SetMusicFileVolume(music_menu, music_vol)
	
	// carrega sfx
	sfx_transicao_in = LoadSoundOGG("sfx/transicao_in.ogg")
	sfx_transicao_out = LoadSoundOGG("sfx/transicao_out.ogg")
	sfx_entrada = LoadSoundOGG("sfx/entrada.ogg")
	sfx_explosao = LoadSoundOGG("sfx/explosao.ogg")
	sfx_explosao_2 = LoadSoundOGG("sfx/explosao_2.ogg")
	sfx_engine = LoadSoundOGG("sfx/engine.ogg")
	sfx_pause = LoadSoundOGG("sfx/pause.ogg")
	sfx_toggle = LoadSoundOGG("sfx/toggle.ogg")
	sfx_blip = loadsoundogg("sfx/blip.ogg")
	sfx_highscore = LoadSoundOGG("sfx/ominous_cancel.ogg")
	
	
	mudaTela("menu")
	PlaySound(sfx_entrada, sfx_vol*2)
	
return


loaderMenu:		// LOADER MENU
	
	StopMusic()
	StopSound(sfx_engine)
	DeleteAllSprites()
	DeleteAllText()
	SetViewOffset(0, 0)
	flagMenu_info = 0
	
	PlayMusic(music_menu, 1)


	// sprite bg menu
	img_menu_bg[0] = LoadImage("ui/VAVAVAV.png")
	img_menu_bg[1] = LoadImage("ui/VAVAVAV-info.png")
	spr_menubg = CreateSprite(img_menu_bg[0])
	SetSpriteScale(spr_menubg, 2, 2)
	SetSpriteDepth(spr_menubg, 10)
	AddSpriteAnimationFrame(spr_menubg, img_menu_bg[0])
	AddSpriteAnimationFrame(spr_menubg, img_menu_bg[1])
	SetSpritePosition(spr_menubg, 0, 0)
	
	// sprite efeito trilha
	img_scroller = LoadImage("ui/img_trilha_efeito.png")
	spr_scroller[0] = CreateSprite(img_scroller)
	SetSpritePosition(spr_scroller[0], 0, 66)
	SetSpriteScale(spr_scroller[0], 2, 2)
	SetSpriteDepth(spr_scroller[0], 13)
	
	offset = GetSpriteWidth(spr_scroller[0])
	spr_scroller[1] = CloneSprite(spr_scroller[0])
	SetSpriteX(spr_scroller[1], -offset)

	// pointer
	spr_pointer = CreateSprite(CreateImageColor(0,0,0,0))
	SetSpriteShape(spr_pointer, 2)
	
	// BOTOES
	// botao info
	img_botao_info[0] = LoadImage("ui/img_botao_info.png")
	img_botao_info[1] = LoadImage("ui/img_botao_info_apertado.png")
	spr_botao_info = CreateSprite(img_botao_info[0])
	SetSpriteDepth(spr_botao_info, 8)
	SetSpriteShape(spr_botao_info, 2)
	SetSpriteScale(spr_botao_info, 2, 2)
	SetSpritePosition(spr_botao_info, 40, 40)
	AddSpriteAnimationFrame(spr_botao_info, img_botao_info[0])
	AddSpriteAnimationFrame(spr_botao_info, img_botao_info[1])
	
	// botao music
	img_botao_music[0] = LoadImage("ui/img_botao_music.png")
	img_botao_music[1] = LoadImage("ui/img_botao_music_apertado.png")
	img_botao_music[2] = LoadImage("ui/img_botao_music_off.png")
	img_botao_music[3] = LoadImage("ui/img_botao_music_apertado_off.png")
	spr_botao_music = CreateSprite(img_botao_music[2 - (2*flagToggleMusic)])
	SetSpriteDepth(spr_botao_music, 8)
	SetSpriteShape(spr_botao_music, 2)
	SetSpriteScale(spr_botao_music, 2, 2)
	SetSpritePosition(spr_botao_music, 120, 40)
	AddSpriteAnimationFrame(spr_botao_music, img_botao_music[0])
	AddSpriteAnimationFrame(spr_botao_music, img_botao_music[1])
	AddSpriteAnimationFrame(spr_botao_music, img_botao_music[2])
	AddSpriteAnimationFrame(spr_botao_music, img_botao_music[3])
	
	// botao sfx
	img_botao_sfx[0] = LoadImage("ui/img_botao_sfx.png")
	img_botao_sfx[1] = LoadImage("ui/img_botao_sfx_apertado.png")
	img_botao_sfx[2] = LoadImage("ui/img_botao_sfx_off.png")
	img_botao_sfx[3] = LoadImage("ui/img_botao_sfx_apertado_off.png")
	spr_botao_sfx = CreateSprite(img_botao_sfx[2 - (2*flagToggleSfx)])
	SetSpriteDepth(spr_botao_sfx, 8)
	SetSpriteShape(spr_botao_sfx, 2)
	SetSpriteScale(spr_botao_sfx, 2, 2)
	SetSpritePosition(spr_botao_sfx, 200, 40)
	AddSpriteAnimationFrame(spr_botao_sfx, img_botao_sfx[0])
	AddSpriteAnimationFrame(spr_botao_sfx, img_botao_sfx[1])
	AddSpriteAnimationFrame(spr_botao_sfx, img_botao_sfx[2])
	AddSpriteAnimationFrame(spr_botao_sfx, img_botao_sfx[3])
	
	// botao zen
	img_botao_zen[0] = LoadImage("ui/img_botao_zen.png")
	img_botao_zen[1] = LoadImage("ui/img_botao_zen_apertado.png")
	img_botao_zen[2] = LoadImage("ui/img_botao_zen_off.png")
	img_botao_zen[3] = LoadImage("ui/img_botao_zen_apertado_off.png")
	spr_botao_zen = CreateSprite(img_botao_zen[2 - (2*flagModoZen)])
	SetSpriteDepth(spr_botao_zen, 8)
	SetSpriteShape(spr_botao_zen, 2)
	SetSpriteScale(spr_botao_zen, 2, 2)
	SetSpritePosition(spr_botao_zen, 320, 40)
	AddSpriteAnimationFrame(spr_botao_zen, img_botao_zen[0])
	AddSpriteAnimationFrame(spr_botao_zen, img_botao_zen[1])
	AddSpriteAnimationFrame(spr_botao_zen, img_botao_zen[2])
	AddSpriteAnimationFrame(spr_botao_zen, img_botao_zen[3])
	
	// sprites particulas
	img_particula = CreateImageColor(0, 255, 0, 255)
	for i = 0 to MAX_PARTICULAS-1
        particula_spriteID[i] = CreateSprite(img_particula)
        id = particula_spriteID[i]
        rand_escala = Random(1, 3)
		SetSpriteScale(id, rand_escala, rand_escala)
        SetSpritePosition(id, Random(0, GetVirtualWidth()), Random(0, GetVirtualHeight()))
        SetSpriteDepth(id, 9999)
        FixSpriteToScreen(id, 1)
    next i
	
	telaAtual = "menu"
return

loaderFase:		// LOADER FASE
	
	// reinicializacao de variaveis gerais
	StopMusic()
	StopSound(sfx_engine)
	DeleteAllSprites()
	DeleteAllText()
	SetViewOffset(0, 0)
	positionX = 0
	positionY = limiteY
	pontos_atual = 0
	counterAngle = 2
	counterTrilha = 0
	counterMorte = 0
	counterEfeitoRecorde = 0
	flagMorte = 0
	flagBateuRecorde = 0
	waveSpeed = 10
	
	
	// reinicializacao da dificuldade
	dificuldade_velocidade_base = 6
    dificuldade_rotacao_base = 0.1
    proximo_spawn_distancia = 600
    counterDificuldade = 0
	
	// reinicializacao das variaveis dos asteroides
	for i = 0 to MAX_ASTEROIDES-1
        spr_asteroides_clones[i] = 0
        asteroide_velocidadeX[i] = 0.0
        asteroide_rotacao[i] = 0.0
    next i
    id_asteroide_colidido = -1
    
    PlaySound(sfx_engine, sfx_vol / 3 , 1)
    PlayMusic(music[Random(0, MAX_MUSICAS-1)], 1)
    
	
	// TEXTOS 
	// texto ponto atual
	text_pontos_atual = CreateText("")
	SetTextSize(text_pontos_atual, 40)
	SetTextPosition(text_pontos_atual, 0, 0)
	FixTextToScreen(text_pontos_atual, 1)
	SetTextFont(text_pontos_atual, fonte)
	SetTextColor(text_pontos_atual, 0, 255, 0, 255)
	SetTextDepth(text_pontos_atual, 6)
	
	// texto recorde
	text_highscore = CreateText("0")
	SetTextSize(text_highscore, 40)
	SetTextPosition(text_highscore, 0, 40)
	FixTextToScreen(text_highscore, 1)
	SetTextFont(text_highscore, fonte)
	SetTextColor(text_highscore, 0, 255, 0, 255)
	SetTextDepth(text_highscore, 6)
	SetTextVisible(text_highscore, 0)
	if (NOT flagModoZen) AND (recorde_normal > 0) then SetTextVisible(text_highscore, 1)
	
	// texto recorde MODO ZEN
	text_highscore_zen = CreateText("0")
	SetTextSize(text_highscore_zen, 40)
	SetTextPosition(text_highscore_zen, 0, 40)
	FixTextToScreen(text_highscore_zen, 1)
	SetTextFont(text_highscore_zen, fonte)
	SetTextColor(text_highscore_zen, 0, 255, 0, 255)
	SetTextDepth(text_highscore_zen, 6)
	SetTextVisible(text_highscore_zen, 0)
	if (flagModoZen) AND (recorde_zen > 0) then SetTextVisible(text_highscore_zen, 1)
	
	// sprite texto highscore
	img_highscore = LoadImage("ui/img_highscore.png")
	spr_highscore = CreateSprite(img_highscore)
	SetSpriteScale(spr_highscore, 2, 2)
	SetSpritePosition(spr_highscore, 312, 102)
	FixSpriteToScreen(spr_highscore, 1)
	SetSpriteVisible(spr_highscore, 0)
	
	
	// sprite radar overlay
	img_radar = LoadImage("ui/img_radar.png")
	spr_radar = CreateSprite(img_radar)
	SetSpritePosition(spr_radar, 0, 0)
	SetSpriteScale(spr_radar, 2, 2)
	SetSpriteDepth(spr_radar, 2)
	FixSpriteToScreen(spr_radar, 1)
	
	// sprite pause
	img_pause = LoadImage("ui/img_pause.png")
	spr_pause = CreateSprite(img_pause)
	SetSpritePosition(spr_pause, 0, 0)
	SetSpriteScale(spr_pause, 2, 2)
	SetSpriteDepth(spr_pause, 5)
	SetSpriteVisible(spr_pause, 0)
	FixSpriteToScreen(spr_pause, 1)
	
	// sprite hitbox
	img_hitbox = CreateImageColor(255, 255, 255, 255)
	spr_hitbox = CreateSprite(img_hitbox)
	SetSpriteScale(spr_hitbox, 10, 10)
	SetSpriteAngle(spr_hitbox, 45)
	SetSpriteShape(spr_hitbox, 2)
	SetSpriteVisible(spr_hitbox, 0)

	// sprite wave
	img_wave = LoadImage("nave/img_wave.png")
	spr_wave = CreateSprite(img_wave)
	SetSpriteScale(spr_wave, 0.5, 0.5)
	SetSpriteDepth(spr_wave, 10)
	SetSpritePosition(spr_wave, 0, 340)
	SetSpritePhysicsOff(spr_wave)
	
	// sprite explosao
	img_explosao = LoadImage("nave/explosao.png")
	spr_explosao = CreateSprite(img_explosao)
	SetSpritePhysicsOff(spr_explosao)
	SetSpriteVisible(spr_explosao, 0)
	SetSpriteScale(spr_explosao, 0.5, 0.5)
	SetSpriteColor(spr_explosao, 0, 255, 0, 255)
	SetSpriteDepth(spr_explosao, 10)
	SetSpritePosition(spr_explosao, 40, 340)
	SetSpriteAnimation(spr_explosao, 320, 320, 12)

	// sprite trilha
	img_trilha = LoadImage("nave/img_trilha1.png")
	spr_trilha = CreateSprite(img_trilha)
	SetSpritePhysicsOff(spr_trilha)
	SetSpriteScale(spr_trilha, 0.5, 0.5)
	SetSpriteDepth(spr_trilha, 20)
	SetSpritePosition(spr_trilha, 0, limiteY)
	
	// sprite asteroide
	img_asteroide[0] = LoadImage("asteroides/meteorGrey_big1.png")
	img_asteroide[1] = LoadImage("asteroides/meteorGrey_big2.png")
	img_asteroide[2] = LoadImage("asteroides/meteorGrey_big3.png")
	img_asteroide[3] = LoadImage("asteroides/meteorGrey_big4.png")
	
	// sprites particulas
	img_particula = CreateImageColor(0, 255, 0, 255)
	for i = 0 to MAX_PARTICULAS-1
        particula_spriteID[i] = CreateSprite(img_particula)
        id = particula_spriteID[i]
		SetSpriteScale(id, 5, 5)
        SetSpritePosition(id, Random(0, GetVirtualWidth()), Random(0, GetVirtualHeight()))
        SetSpriteDepth(id, 9000)
        FixSpriteToScreen(id, 1)
    next i
    
    // sprites particulas morte
    img_particula_morte as integer[2]
		img_particula_morte[0] = CreateImageColor(0, 255, 0, 255) // verde
		img_particula_morte[1] = CreateImageColor(0, 0, 0, 255) // preto

	for i = 0 to MAX_PARTICULAS_MORTE-1
		rand_cor = Random(0,1)
		
		spr_particula_morte[i] = CreateSprite(img_particula_morte[rand_cor])
		id = spr_particula_morte[i]
		
		// tamanho baseado na cor
		if rand_cor = 0
			SetSpriteScale(id, 8, 8)
		else
			SetSpriteScale(id, 16, 16)
		endif
		
		SetSpriteShape(id, 2)                
		SetSpritePhysicsOn(id, 2)            
		SetSpritePhysicsMass(id, 0.01)
		SetSpritePhysicsOff(id)
		SetSpriteVisible(id, 0)
		
		SetSpriteDepth(id, 9)
	next i
	
	// sprite transicao out
	img_black1 = CreateImageColor(0, 0, 0, 255)
	spr_black1 = CreateSprite(img_black1)
	SetSpritePosition(spr_black1, 0, 0)
	FixSpriteToScreen(spr_black1, 1)
	SetSpriteScale(spr_black1, GetVirtualWidth(), GetVirtualHeight())
	SetSpriteDepth(spr_black1, 0)
	
	PlaySound(sfx_transicao_out, sfx_vol *2 )
	telaAtual = "fase"
return

// sistema de transicao de tela especifico pra fase
// pra resolver um problema que eu nao consegui resolver de forma bonita :D
fadeout_fase:
	SetSpriteColorAlpha(spr_black1, GetSpriteColorAlpha(spr_black1) - 17)
	if (GetSpriteColorAlpha(spr_black1) = 0) then DeleteSprite(spr_black1)
	
return

// transicao de tela geral
// aceita "in" e "out" como parametros
function transicao(in_out as string)
	img_black = CreateImageColor(0, 0, 0, 255)
	spr_black = CreateSprite(img_black)
	SetSpritePosition(spr_black, 0, 0)
	FixSpriteToScreen(spr_black, 1)
	SetSpriteScale(spr_black, GetVirtualWidth(), GetVirtualHeight())
	SetSpriteDepth(spr_black, 0)
	
	counterTransicao = 0
	if (in_out = "in")
		alpha_black = 0
		fade = 17
		PlaySound(sfx_transicao_in, sfx_vol *2 )
	elseif (in_out = "out")
		alpha_black = 255
		fade = -17
		PlaySound(sfx_transicao_out, sfx_vol *2 )
	endif
	
	while (counterTransicao < 20)
		SetSpriteColorAlpha(spr_black, alpha_black)
		
		if (in_out = "in")
			if (alpha_black < 255) then alpha_black = alpha_black + fade
		elseif (in_out = "out") 
			if (alpha_black > 0) then alpha_black = alpha_black + fade
		endif
		
		counterTransicao = counterTransicao + 1
		sync()
	endwhile
	
	DeleteSprite(spr_black)
endfunction
