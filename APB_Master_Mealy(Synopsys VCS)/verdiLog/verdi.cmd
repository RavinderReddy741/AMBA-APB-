verdiSetActWin -dock widgetDock_<Watch>
simSetSimulator "-vcssv" -exec \
           "/home/rdonapat/Verilog_Codes/Projects/APB_Master_Mealy/simv" -args \
           "-sml=verdi +UVM_VERDI_TRACE=UVM_AWARE -ucli2Proc -ucli -licqueue"
debImport "-dbdir" \
          "/home/rdonapat/Verilog_Codes/Projects/APB_Master_Mealy/simv.daidir"
debLoadSimResult \
           /home/rdonapat/Verilog_Codes/Projects/APB_Master_Mealy/inter.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "0" "27" "1366" "704"
verdiWindowResize -win $_Verdi_1 "0" "27" "1366" "704"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "apb_ms_tb.dut" -win $_nTrace1
srcSetScope "apb_ms_tb.dut" -delim "." -win $_nTrace1
srcHBSelect "apb_ms_tb.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "apb_ms_tb.dut.APB_Master" -win $_nTrace1
srcSetScope "apb_ms_tb.dut.APB_Master" -delim "." -win $_nTrace1
srcHBSelect "apb_ms_tb.dut.APB_Master" -win $_nTrace1
srcSignalView -on
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "apb_ms_tb.dut.APB_Master.pREADY"
srcSignalViewSelectAll -curPage
srcSignalViewAddSelectedToWave -clipboard
wvDrop -win $_nWave2
wvSetCursor -win $_nWave2 49.994507 -snap {("G1" 11)}
verdiSetActWin -win $_nWave2
verdiFindBar -show -win nWave_2
wvSetCursor -win $_nWave2 50.508149 -snap {("G1" 11)}
wvZoomAll -win $_nWave2
srcHBSelect "apb_ms_tb.dut.slave" -win $_nTrace1
srcSetScope "apb_ms_tb.dut.slave" -delim "." -win $_nTrace1
srcHBSelect "apb_ms_tb.dut.slave" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcSignalViewSelect "apb_ms_tb.dut.slave.pSELX"
srcSignalViewSelectAll -curPage
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewAddSelectedToWave -clipboard
wvDrop -win $_nWave2
srcSignalView -off
verdiDockWidgetMaximize -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 541.635064 -snap {("G1" 16)}
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/apb_ms_tb"
wvGetSignalClose -win $_nWave2
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 690.736851 -snap {("G1" 23)}
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 421.947915 -snap {("G1" 28)}
wvSelectSignal -win $_nWave2 {( "G1" 18 19 20 21 22 23 24 25 26 27 28 29 )} 
wvSelectSignal -win $_nWave2 {( "G1" 24 )} 
wvSetCursor -win $_nWave2 380.361702 -snap {("G1" 20)}
wvSetCursor -win $_nWave2 417.890723 -snap {("G1" 21)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
debExit
