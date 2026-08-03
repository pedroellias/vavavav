
obstaculos:

    // movimento e rotacao dos asteroides
	for i = 0 to MAX_ASTEROIDES-1
		
		// para cada posicao no vetor de asteroides
		if GetSpriteExists(spr_asteroides_clones[i])
			id = spr_asteroides_clones[i]
			
			// deleta asteroides fora da tela
			if GetSpriteX(id) < (positionX - offsetTela - 200)
				DeleteSprite(id)
				
			else
				// colisao com o player
				if GetSpriteCollision(spr_hitbox, id)
					if (NOT flagDebug_noclip) then Gosub morte
					id_asteroide_colidido = id
				endif
				
				// atualiza a sua posicao e rotacao
				if (id_asteroide_colidido <> id)
					SetSpriteX(id, GetSpriteX(id) - asteroide_velocidadeX[i])
					SetSpriteAngle(id, GetSpriteAngle(id) + asteroide_rotacao[i])
				endif
			endif
		endif
		
	next i
	
	// spawna asteroide novo
    if (NOT flagMorte)
        ultimo_asteroide_x = encontrar_posicao_x_do_asteroide_mais_a_direita()
        
        // checa se o asteroide mais a direita ja apareceu na tela antes de spawnar o proximo
        if ultimo_asteroide_x < (positionX + GetVirtualWidth() - proximo_spawn_distancia)
            Gosub spawnNovoAsteroide
        endif
    endif
    
    if (flagModoZen)
		reduzidor_dificuldade = 3
	else
		reduzidor_dificuldade = 1
	endif
	
    // aumenta a dificuldade a cada 5000 pixels
    if (mod(positionX, 5000) < waveSpeed) and (positionX > offsetTela) and (counterDificuldade < 30)
		
		// aumenta velocidade e rotacao dos asteroides
        dificuldade_velocidade_base = dificuldade_velocidade_base + 0.3 / reduzidor_dificuldade
        dificuldade_rotacao_base = dificuldade_rotacao_base + 0.1
        
        // limite de velocidade
        if (waveSpeed < 14) and (mod(counterDificuldade, 3) = 0)
			waveSpeed = waveSpeed + 1
        endif
        
        // limite distancia de spawn
        if (proximo_spawn_distancia > 350) 
            proximo_spawn_distancia = proximo_spawn_distancia - 30 / reduzidor_dificuldade
        endif
        
        counterDificuldade = counterDificuldade + 1
    endif
return

spawnNovoAsteroide:
    slot_vazio = -1
    
	// procura um espaco vazio no vetor de asteroides
    for i = 0 to MAX_ASTEROIDES-1
        if (NOT GetSpriteExists(spr_asteroides_clones[i]))
            slot_vazio = i
            exit
        endif
    next i

	// se achar slot vazio, cria o asteroide novo
    if (slot_vazio > -1)
		
		// clona um asteroide no slot vazio do vetor
		rand_visual = Random(0, QUANT_VISUAIS_ASTEROIDE-1)
		rand_escala = 1 + (Random(0, 5) * 0.1)
		
        spr_asteroides_clones[slot_vazio] = CreateSprite(img_asteroide[rand_visual])
        id = spr_asteroides_clones[slot_vazio]
        
        SetSpriteShape(id, 3)
        SetSpriteDepth(id, 18)
        SetSpriteScale(id, rand_escala, rand_escala)
        
		
		// posicao inicial
		rand_posicao_y = Random(0, total_posicoesY-1)

        asteroide_y = posicoesY_asteroides[rand_posicao_y]  + (Random(-50, 50))
        asteroide_x = GetViewOffsetX() + GetVirtualWidth() + 100
        
        if asteroide_y < 0 then asteroide_y = 0
        if asteroide_y > limiteY - 80 then asteroide_y = limiteY - 80
		
        SetSpritePosition(id, asteroide_x, asteroide_y)
        
        // variacao de velocidade e rotacao
        variacao_velocidade = Random(-10, 15) * 0.1
        asteroide_velocidadeX[slot_vazio] = dificuldade_velocidade_base + variacao_velocidade
        
        variacao_rotacao = Random(-8, 8) * 0.1
        asteroide_rotacao[slot_vazio] = dificuldade_rotacao_base + variacao_rotacao

    endif
return

// nome autodescritivo o suficiente, eu diria
function encontrar_posicao_x_do_asteroide_mais_a_direita()
	maiorX = 0
	
    for i = 0 to MAX_ASTEROIDES-1
        if GetSpriteExists(spr_asteroides_clones[i])
            if GetSpriteX(spr_asteroides_clones[i]) > maiorX
                maiorX = GetSpriteX(spr_asteroides_clones[i])
            endif
        endif
    next i
endfunction(maiorX)
