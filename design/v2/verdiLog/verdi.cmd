verdiSetActWin -dock widgetDock_<Decl._Tree>
simSetSimulator "-vcssv" -exec \
           "/sophoton_users/haomiao.xu/Desktop/Haomiao_XU/bishe/pim/design/v2/simv" \
           -args
debImport "-dbdir" \
          "/sophoton_users/haomiao.xu/Desktop/Haomiao_XU/bishe/pim/design/v2/simv.daidir"
debLoadSimResult \
           /sophoton_users/haomiao.xu/Desktop/Haomiao_XU/bishe/pim/design/v2/device.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "1268" "330" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_my_core.u_block_top" -win $_nTrace1
srcSetScope "tb_my_core.u_block_top" -delim "." -win $_nTrace1
srcHBSelect "tb_my_core.u_block_top" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 9 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "cur_st" -line 67 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "cur_active_idx\[0\]" -line 179 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "cur_active_idx\[1\]" -line 181 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 3 4 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 4 )} 
wvSetRadix -win $_nWave2 -format UDec
wvSetCursor -win $_nWave2 2767.570931 -snap {("G2" 0)}
wvSelectGroup -win $_nWave2 {G2}
wvSetCursor -win $_nWave2 4143.053683 -snap {("G1" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "sorted_dist_r" -line 127 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "sorted_addr_r" -line 128 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSetCursor -win $_nWave2 758.314435 -snap {("G1" 5)}
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSelectSignal -win $_nWave2 {( "G1" 5 6 )} 
wvSelectSignal -win $_nWave2 {( "G1" 5 6 )} 
wvSetRadix -win $_nWave2 -format UDec
