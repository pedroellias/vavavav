
playerMovement:
	
	if (NOT flagMorte) then waveDirection = getWaveDirection()
	
	// atualiza a posicao x e y
	positionX = positionX + waveSpeed * (positionX >= 0)
	positionY = positionY + (waveDirection * waveSpeed * (positionX > offsetTela))

	// limitar movimento do player nas bordas da tela
	if positionY < 0 then positionY = 0
	if positionY > limiteY then positionY = limiteY

	// angulo da wave e trilha
	if (positionY = 0 OR positionY = limiteY)
			counterAngle = counterAngle + 1
		else
			counterAngle = counterAngle - 1
	endif
	if (counterAngle > 2) then counterAngle = 2
	if (counterAngle < 0) then counterAngle = 0
	
	if counterAngle > 1
		Gosub criarTrilha
		SetSpriteAngle(spr_wave, 0)
		SetSpriteAngle(spr_trilha, 0)
	else 
		SetSpriteAngle(spr_wave, (waveDirection * 45))
		SetSpriteAngle(spr_trilha, (waveDirection * 45))
		Gosub criarTrilha
	endif
	
	SetSpritePosition(spr_wave, positionX, positionY)
	SetSpritePosition(spr_hitbox, positionX+15, positionY+15)
	SetSpritePosition(spr_trilha, positionX, positionY)
	
return

playerCamera:
	// move a camera com o player a partir de x=240
	if (positionX >= offsetTela) 
		SetViewOffset(positionX - offsetTela, 0)
	endif
return

criarTrilha:
    counterTrilha = counterTrilha + 1
    if (counterTrilha > 29) then counterTrilha = 0
    spr_clonetrilha[counterTrilha] = CloneSprite(spr_trilha)
    for j = 0 to 30
		if (GetSpriteExists(spr_clonetrilha[j]))
			if (GetSpriteColorGreen(spr_clonetrilha[j]) > 20)
				SetSpriteColorGreen(spr_clonetrilha[j], GetSpriteColorGreen(spr_clonetrilha[j])-5)
			endif
			SetSpriteColorAlpha(spr_clonetrilha[j], GetSpriteColorAlpha(spr_clonetrilha[j])-8)
			if (GetSpriteColorAlpha(spr_clonetrilha[j]) <= 20) then DeleteSprite(spr_clonetrilha[j])
		endif
    next j
return

function getWaveDirection()
	if GetRawKeyState(KEY_SPACE) OR GetRawKeyState(KEY_UP) OR GetPointerState() // 90 = Z
		direction = -1
	else
		direction = 1
	endif
endfunction(direction)

printDebug: // printa informacoes na tela
    Print("- DEBUG MODE -")
    Print("FPS: " + str(ScreenFPS()))
    if (flagDebug_noclip) then print("NOCLIP ativado")
    
    Print("")
    
    Print("- JOGADOR -")
    Print("Pos X: " + str(positionX))
    Print("Pos Y: " + str(positionY))
    Print("Velocidade X/Y: " + str(waveSpeed))
    
    Print("")
    
    Print("- OBSTACULOS (DIFICULDADE) -")
    Print("Velocidade Base: " + str(dificuldade_velocidade_base))
    Print("Rotacao Base: " + str(dificuldade_rotacao_base))
    Print("Distancia Spawn: " + str(proximo_spawn_distancia))
    Print("Counter Dificuldade: " + str(counterDificuldade))
    
return
