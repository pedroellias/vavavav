
atualizarParticulas:

	// fatores das velocidade e esticamento das particulas
	velocidade_atual = waveSpeed + (counterDificuldade)
	velocidade_base_particula = 0.5

	for i = 0 to MAX_PARTICULAS-1
		id = particula_spriteID[i]
		
		if GetSpriteExists(id)
			// cada particula é atribuida um tipo de 0 a 4 baseado no seu id
			tipo_particula = mod(id, 5)
			
			// atribui propriedades para cada tipo de particula
			select (tipo_particula)
				case 0
					velocidade_individual = 0
					stretch_x = 1
					stretch_y = 1
				endcase
				
				case 1:
					velocidade_individual = (velocidade_base_particula + velocidade_atual) * 0.5
					stretch_x = 1 + (velocidade_individual) * FATOR_STRETCH
					stretch_y = 1
				endcase
				
				case 2:
					velocidade_individual = (velocidade_base_particula + velocidade_atual) * 1
					stretch_x = 1 + (velocidade_individual) * FATOR_STRETCH
					stretch_y = 1
				endcase
				
				case 3:
					velocidade_individual = (velocidade_base_particula + velocidade_atual) * 1.5
					stretch_x = 1 + (velocidade_individual) * FATOR_STRETCH
					stretch_y = 1
				endcase
				
				case 4:
					SetSpriteColor(id, 0, 0, 0, 255)
					stretch_y = 16
					stretch_x = stretch_x * 8
					velocidade_individual = (velocidade_base_particula + velocidade_atual) * 8
				endcase
			endselect	
			
			// recicla particulas fora da tela
			if (GetSpriteX(id) < -10)
				SetSpriteX(id, GetVirtualWidth() + 10)
				SetSpriteY(id, Random(0, GetVirtualHeight()))
			endif
			
			// atualiza o stretch e a posicao
			SetSpriteX(id, GetSpriteX(id) - velocidade_individual)
			SetSpriteScale(id, stretch_x, stretch_y)
			
			
		endif
	next i
return

// mesma coisa mas diferente. para o menu
atualizarParticulas_menu:

		for i = 0 to MAX_PARTICULAS-1
			id = particula_spriteID[i]
			if GetSpriteExists(id)
				
				// 1% de chance de diminuir alpha
				if (random(1, 100) = 100)
					SetSpriteColorAlpha(id, GetSpriteColorAlpha(id) - 85)
				endif
				
				// recicla particulas invisiveis
				if (GetSpriteColorAlpha(id) = 0)
					SetSpritePosition(id, Random(0, GetVirtualWidth()), Random(0, GetVirtualHeight()))
					SetSpriteColorAlpha(id, 255)
				endif
				
			endif
		next i
return
