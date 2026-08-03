// chamado no main loop
atualizarPontos:
	pontos_atual = positionX / 1000.0
	
	string_pontos_atual = converte_pontos_para_string_com_uma_casa_decimal(pontos_atual)
	if (NOT flagMorte)
		SetTextString(text_pontos_atual, "- DISTÂNCIA: " + string_pontos_atual + " KM -")
		SetTextString(text_highscore, "- RECORDE (NORMAL): " + string_recorde_normal + " KM -")
		SetTextString(text_highscore_zen, "- RECORDE (ZEN): " + string_recorde_zen + " KM -")
	endif
	
	SetTextX(text_pontos_atual, (GetVirtualWidth() / 2) - GetTextLength(text_pontos_atual)*9) // centraliza o texto (aproximado eu acho,,????)
	SetTextX(text_highscore, (GetVirtualWidth() / 2) - GetTextLength(text_highscore)*9)
	SetTextX(text_highscore_zen, (GetVirtualWidth() / 2) - GetTextLength(text_highscore_zen)*9)
	
	if (flagHouvePrimeiraMorte) AND (NOT flagMorte)
		
		if (NOT flagModoZen) AND (pontos_atual > recorde_normal) AND (recorde_normal > 0)
			
			flagBateuRecorde = 1
			
		elseif (flagModoZen) AND (pontos_atual > recorde_zen) AND (recorde_zen > 0)
			flagBateuRecorde = 1
			
		endif
	endif

	// efeito piscar o texto quando bater o recorde
	if (flagBateuRecorde) AND (counterEfeitoRecorde < 120)
		SetSpriteVisible(spr_highscore, 1)
		if (mod(counterEfeitoRecorde, 12) = 0) then playsound(sfx_blip, sfx_vol * 1.5)
		
		if (mod(counterEfeitoRecorde, 12) > 5)
			
			SetTextVisible(text_pontos_atual, 0)
			
			if (NOT flagModoZen)
				SetTextVisible(text_highscore, 0)
			else
				SetTextVisible(text_highscore_zen, 0)
			endif
			SetSpriteVisible(spr_highscore, 0)
		else
			SetTextVisible(text_pontos_atual, 1)
			if (NOT flagModoZen)
				SetTextVisible(text_highscore, 1)
			else
				SetTextVisible(text_highscore_zen, 1)
			endif
			SetSpriteVisible(spr_highscore, 1)
		endif
		
		counterEfeitoRecorde = counterEfeitoRecorde + 1
	else
		SetTextVisible(text_pontos_atual, 1)

		SetSpriteVisible(spr_highscore, 0)
	endif
return

// chamada uma vez no momento da morte
atualizarRecorde:

	if (NOT flagModoZen) AND (pontos_atual > recorde_normal)
		recorde_normal = pontos_atual
		string_recorde_normal = string_pontos_atual
		flagHouvePrimeiraMorte = 1
		
	elseif (pontos_atual > recorde_zen)
		recorde_zen = pontos_atual
		string_recorde_zen = string_pontos_atual
		flagHouvePrimeiraMorte = 1
		
	endif
return

// transforma o float em uma casa decimal e salva numa string para display apenas
function converte_pontos_para_string_com_uma_casa_decimal(pontos as float) // top 10 nomes de funcoes
	
	parteinteira = floor(pontos)
	casadecimal = mod((pontos * 10), 10)
	
	string_pontos_atual_display$ = str(parteinteira) + "." + str(casadecimal)
	
endfunction(string_pontos_atual_display$)
