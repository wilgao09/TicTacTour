
:- import winning_triple/3 from gamerule.
:- import in_list/2, every_other/2, append_lists/3, list_len/2, write_to_file/2, add_new_line/1, remove_on_cond/3 from util.
:- import construct_equiv_boards/2 from condense_games.
:- hilog is_equiv_game.

valid_move(1).
valid_move(2).
valid_move(3).
valid_move(4).
valid_move(5).
valid_move(6).
valid_move(7).
valid_move(8).
valid_move(9).

valid_game([]).
valid_game([H|T], L) :- valid_move(H), \+in_list(L, H), valid_game(T, [H|L]).


%%super lame because it will always try rfom 1 and move to 9
%% +B takes a board and returns -N, a valid next move 

create_next_move(B, N) :- valid_move(X), \+in_list(B, X), N=X.

winner(B, P) :- (is_p1_win(B)) -> (P=1) ; ( (is_p2_win(B)) ->(P=2);(fail) ).
is_p1_win(B) :- every_other(B, P1), winning_triple(X,Y,Z), in_list(P1, X), in_list(P1, Y), in_list(P1,Z).
is_p2_win([H|T]) :- is_p1_win(T).

filled_board(B) :- list_len(B,S), S=9.

is_equiv_game(G1)(G2) :- 
    construct_equiv_boards(G1, GList), !,
    in_list(GList, G2).
    
%% given a board state, give all possible next boards that wont create repeat boards
find_all_possible_nexts(B, L) :-
    \+ winner(B, _),
    findall(M, create_next_move(B,M), LMoves),
    elim_equiv(B, LMoves, Elimed),

    L = Elimed.
elim_equiv(_, [], []).


elim_equiv(B, [H|T], O) :- 
    elim_equiv(B, T, O1),
    append_lists(B, [H], BNew),
    ((fail_if_board_already_exists(O1, BNew)) -> (
        O = [BNew|O1]
    );(
        O = O1
    )).

fail_if_board_already_exists([H|T], B) :-
    ((is_equiv_game(B)(H)) -> (
        fail
    ) ; (
        fail_if_board_already_exists(T,B)
    )).
fail_if_board_already_exists([], _).


play_out_game :-
    play_out_game_aux([], _, Hist),
    write_to_file('TTTGame.txt', Hist),
    add_new_line('TTTGame.txt'),
    write('ADD NEW LINE'),
    fail.





play_out_game_aux(CState, NState, Hist) :-
    create_next_move(CState, NextMove),
    append_lists(CState, [NextMove], ONS),
    NState = ONS,
    ((filled_board(NState);winner(NState, P)) -> (Hist=[NState]);(  play_out_game_aux(NState, NNState, FHist), Hist = [NState|FHist] )).