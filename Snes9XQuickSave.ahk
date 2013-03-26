#NoEnv
#SingleInstance
SendMode InputThenPlay


; Minimum to be considered "pressed", between 1 (0.39%) and 255 (100%).
Threshold = 64
; Keys to bind to triggers.
LT_Key = [
RT_Key = ]


LastRT := LastLT := LastStart := LastBack := 0
XInput_Init()
while Hndl := WinExist("ahk_class Snes9X: WndClass") {
    Loop, 4 {
        if State := XInput_GetState(A_Index-1) {
            LT := State.bLeftTrigger >= Threshold
            RT := State.bRightTrigger >= Threshold
			Back := (State.wButtons & XINPUT_GAMEPAD_BACK) > 0
			Start := (State.wButtons & XINPUT_GAMEPAD_START) > 0
           ; Tooltip % "LT: " . LT . "`nRT: " . RT . "`nBack: " . Back . "`nStart: " . Start
			if(LT and RT)
			{
				if((Back != LastBack) and Back)
				{
					WinActivate, ahk_id %Hndl%
					Send {F1}
				}
				if((Start != LastStart) and Start)
				{
					WinActivate, ahk_id %Hndl%
					Send !fs1
					
				}				
			}
			if(Back != LastBack)
			{
				LastBack := Back
			}
			if(Start != LastStart)
			{
				LastStart := Start
			}
        }
    }
    Sleep, 100
}