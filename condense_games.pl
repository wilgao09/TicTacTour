
:- import cc/2, flipx/2 from gamerule.
:- table equivalent_games/2.
:- export find_equiv_board_cc/2, find_equiv_board_fx/2, construct_equiv_boards/2.

find_equiv_board_cc([H1|T1], B2) :- cc(H1, HNew), find_equiv_board_cc(T1, BNew), B2 = [HNew | BNew].
find_equiv_board_cc([X|[]], B2) :- cc(X,XOut), B2 = [XOut].
find_equiv_board_cc([], []). 

find_equiv_board_fx([H1|T1], B2) :- flipx(H1, HNew), find_equiv_board_fx(T1, BNew), B2 = [HNew | BNew].
find_equiv_board_fx([X|[]], B2) :- flipx(X,XOut), B2 = [XOut].
find_equiv_board_fx([], []). 


construct_equiv_boards(B, BList) :- find_equiv_board_cc(B, CC1), find_equiv_board_cc(CC1, CC2), find_equiv_board_cc(CC2, CC3),find_equiv_board_fx(B, CCF1), find_equiv_board_cc(CCF1, CCF2), find_equiv_board_cc(CCF2, CCF3), find_equiv_board_cc(CCF3, CCF4), BList = [B, CC1, CC2, CC3, CCF1, CCF2, CCF3, CCF4].

equivalent_games(X,Y) :- (X = Y) ; 
    (find_equiv_board_cc(Y, Y1), equivalent_games(X,Y1)) ; 
    (find_equiv_board_fx(Y, Y2), equivalent_games(X,Y2)).

