Bank_Flags = $2005
DMA_Flags = $2007

Audio_Reset = $2000
Audio_NMI = $2001
Audio_Rate = $2006


;The two gamepad port addresses
GamePad1 = $2008
GamePad2 = $2009

VIA_ORB = $2800
VIA_ORA = $2801
VIA_DDRB = $2802
VIA_DDRA = $2803
VIA_T1C = $2805
VIA_ACR = $280B
VIA_PCR = $280C
VIA_IFR = $280D
VIA_IER = $280E

AudioRAM = $3000


Framebuffer = $4000
DMA_VX = $4000
DMA_VY = $4001
DMA_GX = $4002
DMA_GY = $4003
DMA_WIDTH = $4004
DMA_HEIGHT = $4005
DMA_Status = $4006
DMA_Color = $4007


;Define some macros to make register values more descriptive

;Input masks for the Gamepad registers
INPUT_MASK_UP		= %00001000 ;Always given
INPUT_MASK_DOWN		= %00000100 ;Always given
INPUT_MASK_LEFT		= %00000010 ;Only on second read
INPUT_MASK_RIGHT	= %00000001 ;Only on second read
INPUT_MASK_A		= %00010000 ;Only on first read
INPUT_MASK_B		= %00010000 ;Only on second read
INPUT_MASK_C		= %00100000 ;Only on second read
INPUT_MASK_START	= %00100000 ;Only on first read


;For DMA_Flags:
DMAMODE = 1
VID_OUT_PAGE2 = 2
VNMI_ENABLE = 4
COLORFILL = 8
NOTILE = 16
MAP_FRAMEBUFFER = 32
BLIT_IRQ = 64
OPAQUE = 128
;For Bank_Flags
VRAMBANK2 = 8
CLIP_X = 16
CLIP_Y = 32

;Color defines
HUE_GREEN = 0
HUE_YELLOW = 32
HUE_ORANGE = 64
HUE_RED = 96
HUE_MAGENTA = 128
HUE_INDIGO = 160
HUE_BLUE = 192
HUE_CYAN = 224

SAT_NONE = 0
SAT_SOME = 8
SAT_MORE = 16
SAT_FULL = 24
