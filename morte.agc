// chamado no instante da colisao
morte:

    if flagMorte = 0
        flagMorte = 1
        
        PlaySound(sfx_explosao, sfx_vol )
        playsound(sfx_explosao_2, sfx_vol /2)
        
        Gosub atualizarRecorde
        
        // animacao spr_explosao
        SetSpritePosition(spr_explosao, positionX-60, positionY-60)
        SetSpriteVisible(spr_explosao, 1)
        SetSpriteVisible(spr_wave, 0)
        SetSpriteVisible(spr_trilha, 0)
        PlaySprite(spr_explosao, 12, 0)

        // particulas de morte
        for i = 0 to MAX_PARTICULAS_MORTE-1
            id = spr_particula_morte[i]

            SetSpritePosition(id, positionX, positionY)
            SetSpriteVisible(id, 1)
            SetSpritePhysicsOn(id, 2)
            
            angulo_explosao = Random(1, 360)
            forca_explosao = 100 + random(-100, 100) * 10
            
            impulso_x = angulo_explosao * forca_explosao
            impulso_y = angulo_explosao * forca_explosao
            
            // aplica forcas na particula
            SetSpritePhysicsImpulse(id, positionX, positionY, impulso_x, impulso_y)
        next i
    endif
return

logicaEnquantoMorto:

    if flagMorte = 1
    
        // fade out e delete das particulas
        for i = 0 to MAX_PARTICULAS_MORTE-1
            id = spr_particula_morte[i]
            if GetSpriteExists(id)
                alpha_atual = GetSpriteColorAlpha(id)
                SetSpriteColorAlpha(id, alpha_atual - 4)
                
                if GetSpriteColorAlpha(id) <= 0
                    DeleteSprite(id)
                    
                endif
                
            endif
            
        next i
        
        // desacelera o jogador
        if (waveSpeed >= 0) 
			waveSpeed = waveSpeed - 0.2
			
		endif
		if (waveSpeed < 0)
			waveSpeed = 0
			
		endif
		
		// counter antes de reiniciar 
        counterMorte = counterMorte + 1
        if counterMorte > 50 
			DeleteSprite(spr_explosao)
            mudaTela("fase") 
        endif
    endif
return
