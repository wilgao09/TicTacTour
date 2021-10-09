
:- export in_list/2, rev/3, append_lists/3, every_other/2, list_len/2, write_to_file/2, add_new_line/1, remove_on_cond/3.

%% :- hilog remove_on_cond.

in_list([],_) :- fail.
in_list([H|T], O) :- (O=H); (in_list(T,O)).


rev([H|T], [], O) :- rev(T, [H], O1), O=O1.
rev([H|T], A, O) :- rev(T, [H|A], O1), O=O1.
rev([], A, O) :- O=A.
rev([],[],[]).

append_lists([], L, L).
append_lists([H|T], L, O) :- append_lists(T, L, O1), O = [H|O1].

every_other([H|T], Lout) :- every_other_aux([H|T], 1, L), Lout = L.

every_other_aux([H|T], 1, Lout) :- every_other_aux(T, 0, L), Lout = [H|L].
every_other_aux([H|T], 0, Lout) :- N=0, every_other_aux(T, 1, L), Lout = L.
every_other_aux([E], 1, Lout) :- Lout = [E].
every_other_aux([_], 0, Lout) :- Lout = [].

list_len([], 0).
list_len([H|T], S) :- list_len(T,Ss), S=Ss+1.

write_to_file(F,A) :-
    open(F,append,S),
    set_output(S),
    write(A),
    close(S).

add_new_line(F) :-
    open(F,append,S),
    set_output(S),
    nl(S),
    close(S).


remove_on_cond([H|T], C, O) :-
    remove_on_cond(T, C, O1),
    (C(H) -> (
        O = O1
    ) ; (
        O = [H|O1]
    )).

remove_on_cond([], _, []).