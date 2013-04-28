(* Generate board.clf from board.txt *)

structure Board = 
struct
 
val nums = 
["rollOne",
 "rollTwo",
 "rollThree",
 "rollFour",
 "rollFive",
 "rollSix"]

val spaces = 
["go_0",
 "ma_1",
 "cc_2",
 "ba_3",
 "ic_4",
 "rr_5",
 "oa_6",
 "ch_7",
 "va_8",
 "ca_9",
 "vj_10",
 "sc_11",
 "ec_12",
 "sa_13",
 "va_14",
 "pr_15",
 "sj_16",
 "cc_17",
 "ta_18",
 "ny_19",
 "fp_20",
 "ka_21",
 "ch_22",
 "ia_23",
 "ia_24",
 "br_25",
 "aa_26",
 "va_27",
 "ww_28",
 "mg_29",
 "gj_30",
 "pa_31",
 "nc_32",
 "cc_33",
 "pa_34",
 "sl_35",
 "ch_36",
 "pp_37",
 "lt_38",
 "bw_39"]
  
val outs = ref TextIO.stdOut

fun print x = TextIO.output (!outs, x)

fun roll n = List.nth (nums, n-1)

fun dice n = 
   if n > 6 then () 
   else (print (roll n^" : roll.\n"); dice (n+1)) 

fun succ pos n = 
   if n > 6 then () 
   else let
           val this = List.nth (spaces, pos)
           val next = List.nth (spaces, (pos + n) mod 40);
        in print ("succ_"^Int.toString pos^"_"^Int.toString n)
         ; print (" : succ "^this^" "^roll n^" "^next^".\n")
         ; succ pos (n+1)
        end

fun succs pos = 
   if pos >= 40 then ()
   else (succ pos 1; succs (pos+1))

val () = 
   let val output = TextIO.openOut "board_auto.clf"
   in outs := output
    ; print "% This file automatically generated by loading 'board_auto.sml'\n"
    ; print "% Do not edit this file!\n\n"
    ; print "% Values generated by rolling a six-sided die\n"
    ; print "roll : type.\n"
    ; dice 1
    ; print "\n% Positions on the board (40 of them -- XXX plus the jail?)\n"
    ; print "position : type.\n"
    ; app (fn x => (print x; print " : position.\n")) spaces
    ; print "\n% Advancement by a single dice roll\n"
    ; print "succ : position -> roll -> position -> type.\n"
    ; succs 0
   end

end
