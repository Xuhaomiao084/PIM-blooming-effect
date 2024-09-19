verdiSetActWin -dock widgetDock_<Decl._Tree>
simSetSimulator "-vcssv" -exec \
           "/sophoton_users/haomiao.xu/Desktop/Haomiao_XU/bishe/pim/design/v3/simv" \
           -args
debImport "-dbdir" \
          "/sophoton_users/haomiao.xu/Desktop/Haomiao_XU/bishe/pim/design/v3/simv.daidir"
debLoadSimResult \
           /sophoton_users/haomiao.xu/Desktop/Haomiao_XU/bishe/pim/design/v3/device.fsdb
wvCreateWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_my_core.u_block_top" -win $_nTrace1
srcSetScope "tb_my_core.u_block_top" -delim "." -win $_nTrace1
srcHBSelect "tb_my_core.u_block_top" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_my_core.u_block_top.genblk1\[27\]" -win $_nTrace1
srcSetScope "tb_my_core.u_block_top.genblk1\[27\]" -delim "." -win $_nTrace1
srcHBSelect "tb_my_core.u_block_top.genblk1\[27\]" -win $_nTrace1
srcHBSelect "tb_my_core.u_block_top.genblk1\[27\].u_block_top" -win $_nTrace1
srcSetScope "tb_my_core.u_block_top.genblk1\[27\].u_block_top" -delim "." -win \
           $_nTrace1
srcHBSelect "tb_my_core.u_block_top.genblk1\[27\].u_block_top" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ref_dist" -line 24 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcHBSelect "tb_my_core.u_block_top.u_sort" -win $_nTrace1
srcSetScope "tb_my_core.u_block_top.u_sort" -delim "." -win $_nTrace1
srcHBSelect "tb_my_core.u_block_top.u_sort" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_my_core.u_block_top" -win $_nTrace1
srcSetScope "tb_my_core.u_block_top" -delim "." -win $_nTrace1
srcHBSelect "tb_my_core.u_block_top" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 9 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "cur_st" -line 69 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "cur_active_idx\[0\]" -line 183 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "cur_active_idx\[1\]" -line 185 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSelectSignal -win $_nWave2 {( "G1" 4 5 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 4 5 )} 
wvSetRadix -win $_nWave2 -format UDec
wvSetCursor -win $_nWave2 2454.447326 -snap {("G1" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "distance" -line 205 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
wvSetRadix -win $_nWave2 -format UDec
wvSetCursor -win $_nWave2 1555.686467 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 1613.438169 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2577.169692 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2476.104214 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2566.341248 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2476.104214 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2537.465397 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2458.056807 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2555.512804 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2490.542139 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2537.465397 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2476.104214 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2555.512804 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 3717.765802 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 3811.612318 -snap {("G1" 3)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
