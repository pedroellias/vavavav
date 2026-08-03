SetErrorMode(2)               
SetWindowTitle("VAVAVAV")
SetWindowSize(1280, 720, 0)
SetVirtualResolution(1280, 720)
//SetSyncRate(60, 0)
SetWindowAllowResize(1)
SetVSync(1)

#include "loader.agc"
#include "playerMovement.agc"
#include "obstaculos.agc"
#include "efeito_particulas.agc"
#include "morte.agc"
#include "menu.agc"
#include "pontuacao.agc"

// CONSTANTES TECLADO
#constant KEY_SPACE     32
#constant KEY_UP        38
#constant KEY_ESCAPE    27
#constant KEY_ENTER		13
#constant KEY_R         82
#constant KEY_0         48
#constant KEY_1         49
#constant KEY_2         50
#constant KEY_3         51

// FONTE
fonte as integer
fonte = LoadFont("MatchupPro.ttf")
SetPrintFont(fonte)
SetPrintSize(22)

SetPrintColor(0, 255, 0)

// DESATIVAR FILTROS
SetTextDefaultMinFilter(0)
SetTextDefaultMagFilter(0)
SetDefaultMagFilter(0)
SetDefaultMinFilter(0)

// VARIAVEIS GERAL JOGADOR
positionX as integer
positionY as integer
waveSpeed as float = 10
waveDirection as integer
limiteY as integer = 680 // limite inferior da tela
offsetTela as integer = 240
counterAngle as integer
counterTrilha as integer
counterMorte as integer
counterDificuldade as integer
counterTransicao as integer
counterEfeitoRecorde as integer
counterEsc as integer
spr_clonetrilha as integer[30]

// VARIAVEIS PONTUACAO
pontos_atual as float
recorde_normal as float
recorde_zen as float
string_pontos_atual as string
string_recorde_normal as string
string_recorde_zen as string

// VARIAVEIS ASTEROIDES
#constant MAX_ASTEROIDES 20 
global spr_asteroides_clones as integer[MAX_ASTEROIDES]
global asteroide_velocidadeX as float[MAX_ASTEROIDES]
global asteroide_rotacao as float[MAX_ASTEROIDES]
global id_asteroide_colidido as integer

#constant QUANT_VISUAIS_ASTEROIDE 4
img_asteroide as integer[QUANT_VISUAIS_ASTEROIDE]

#constant total_posicoesY 13
global posicoesY_asteroides as integer[total_posicoesY]
	posicoesY_asteroides[0] = 0     
    posicoesY_asteroides[1] = 72
    posicoesY_asteroides[2] = 145
    posicoesY_asteroides[3] = 217
    posicoesY_asteroides[4] = 290
    posicoesY_asteroides[5] = 362
    posicoesY_asteroides[6] = 435
    posicoesY_asteroides[7] = 507
    posicoesY_asteroides[8] = 600
    // redundancia pra aumentar a chance de spawn
    posicoesY_asteroides[9] = 600
    posicoesY_asteroides[10] = 600
    posicoesY_asteroides[11] = 0
    posicoesY_asteroides[12] = 0

global dificuldade_velocidade_base as float
global dificuldade_rotacao_base as float
global proximo_spawn_distancia as integer

// VARIAVEIS PARTICULAS DE VELOCIDADE
#constant MAX_PARTICULAS 200
global particula_spriteID as integer[MAX_PARTICULAS]
fator_stretch as float = 1

#constant MAX_PARTICULAS_MORTE 60
spr_particula_morte as integer[MAX_PARTICULAS_MORTE]

// VARIAVEIS FLAGS
flagMorte as integer
flagDebug as integer
flagDebug_fps as integer
flagDebug_noclip as integer
flagPausado as integer
flagMenu_info as integer
telaAtual as string 

flagModoZen as integer
flagHouvePrimeiraMorte as integer
flagBateuRecorde as integer

// VARIAVEIS MENU
spr_scroller as integer[2]
offsetEfeitoTrilha_menu as integer
img_botao_info as integer[2]
img_botao_music as integer[4]
img_botao_sfx as integer[4]
img_botao_zen as integer[4]
img_menu_bg as integer[2]

// VARIAVEIS MUSICA E SFX
#constant MAX_MUSICAS 3
music as integer[MAX_MUSICAS]
global music_vol as integer = 3
global sfx_vol as integer = 3

flagToggleMusic as integer
flagToggleSfx as integer

global sfx_transicao_in as integer
global sfx_transicao_out as integer

Gosub loaderInicial
//Gosub loaderMenu

do 
	if (NOT flagToggleMusic) 
		music_vol = 0
	else
		music_vol = 3
	endif
	if (NOT flagToggleSfx)
		sfx_vol = 0
	else
		sfx_vol = 3
	endif
	
	for i = 0 to MAX_MUSICAS-1
		SetMusicFileVolume(music[i], music_vol)
	next i
	SetMusicFileVolume(music_menu, music_vol)
	
    if (telaAtual = "menu")

		Gosub atualizarParticulas_menu
		Gosub atualizarTrilha_menu
		Gosub logicaMenu

	endif
	
	if (telaAtual = "fase")
		
		// transicao fade out
		if (GetSpriteExists(spr_black1)) then Gosub fadeout_fase
		
		// rotinas de funcionamento
		Gosub playerMovement
		Gosub playerCamera
		Gosub obstaculos
		Gosub atualizarParticulas
		Gosub logicaEnquantoMorto
		Gosub atualizarPontos
		
		if (GetRawKeyReleased(KEY_ESCAPE)) then Gosub pausarJogo
		
		// FUNCOES DEBUG --- REMOVER NA VERSAO FINAL !!!
		//if flagDebug
			//Gosub printDebug
			//if (GetRawKeypressed(KEY_2)) then flagDebug_noclip = NOT flagDebug_noclip
			//SetPhysicsDebugOn()
			//if (GetRawKeyPressed(KEY_3)) then flagDebug_fps = NOT flagDebug_fps
		
		//else
			//SetPhysicsDebugOff()
		//endif
		//if (flagDebug_fps)
			//SetSyncRate(0,0)
		//else
			//SetSyncRate(60,0)
		//endif
		
		//if (GetRawKeypressed(KEY_1)) then flagDebug = NOT flagDebug
		if (GetRawKeyReleased(KEY_R)) then Gosub morte
		
    endif
    
    Sync()
loop

function mudaTela(tela as string)
	
	if tela = "menu"
		transicao("in")
		Gosub loaderMenu
		transicao("out")
		
	elseif tela = "fase"
		transicao("in")
		Gosub loaderFase
		// transicao out aqui eh feita por sistema separado (gosub fadeout_fase)
	endif

endfunction

