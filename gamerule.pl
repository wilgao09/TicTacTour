:- export cc/2, flipx/2, winning_triple/3.

cc(1, 7).
cc(2, 4).
cc(3, 1).
cc(4, 8).
cc(5, 5).
cc(6, 2).
cc(7, 9).
cc(8, 6).
cc(9, 3).



flipx(1, 7).
flipx(2, 8).
flipx(3, 9).
flipx(X, X) :- X is 4 ; X is 5 ; X is 6.
flipx(X,Y) :- flipx(Y, X).


winning_triple(1,2,3).
winning_triple(4,5,6).
winning_triple(7,8,9).
winning_triple(1,4,7).
winning_triple(2,5,8).
winning_triple(3,6,9).
winning_triple(1,5,9).
winning_triple(3,5,7).
