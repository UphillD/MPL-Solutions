% Exercise 1
% Define a predicate max(X,Y,Z) that takes numbers X and Y and unifies Z with the maximum of the two.
max(X, Y, Z) :-
    X > Y,
    Z is X.
max(X, Y, Z) :-
    X =< Y,
    Z is Y.

% Exercise 2
% Define a predicate maxlist(L,M) that takes a list L of numbers and unifies M with the maximum number in the list.
maxlist([X], X).
maxlist([H|T], H) :-
    maxlist(T, Mt),
    H > Mt.
maxlist([H|T], Mt) :-
    maxlist(T, Mt),
    H =< Mt.

% Exercise 3
% Define a predicate ordered(L) that succeeds if and only if the list of numbers L is in non-decreasing order - each element is less than or equal to the next.
ordered([_]).
ordered([A, B|T]) :-
    A =< B,
    ordered([B|T]).

% Exercise 4
% Define a predicate mergesort(In,Out) that makes a sorted version of a list In of numbers and unifies the result with Out. Your predicate should use a merge-sort algorithm.
halve([], [], []).
halve([X], [X], []).
halve([A, B|T1], [A|Ta], [B|Tb]) :-
    halve(T1, Ta, Tb).
merge([], Y, Y).
merge(X, [], X).
merge([X|Tx], [Y|Ty], [X|Ts]) :-
    X =< Y,
    merge(Tx, [Y|Ty], Ts).
merge([X|Tx], [Y|Ty], [Y|Ts]) :-
    X > Y,
    merge([X|Tx], Ty, Ts).
mergesort([], []).
mergesort([X], [X]).
mergesort(In, Out) :-
    halve(In, X, Y),
    mergesort(X, Xs),
    mergesort(Y, Ys),
    !,
    merge(Xs, Ys, Out).

% Exercise 5
% Define a predicate nqueens(N,X) that takes an integer N and finds a solution X to the N-queens problem.
% nocheck(X/Y, L) takes a queen X/Y and a list of queens. We succeed if and only if the X/Y queen holds none of the others in check.
nocheck(_, []).
nocheck(X/Y, [X1/Y1|Rest]) :-
    Y =\= Y1,
    abs(Y1-Y) =\= abs(X1-X),
    nocheck(X/Y, Rest).

% legal(L) succeeds if L is a legal placement of queens: all coordinates in range and no queen in check.
legal([], _).
legal([X/Y|Rest], L) :-
    legal(Rest, L),
    member(Y, L),
    nocheck(X/Y, Rest).

createlists(1, C, [C/_], [C]).
createlists(N, C, [C/_|Tx], [C|Tl]) :-
    N1 is N - 1,
    C1 is C + 1,
    createlists(N1, C1, Tx, Tl).

nqueens(N, X) :-
    createlists(N, 1, X, L),
    legal(X, L).

% Exercise 6
% Define a predicate subsetsum(L, Sum, SubL) that takes a list L of numbers and a number Sum and unifies SubL with a subsequence of L such that the sum of the numbers in SubL is Sum.
subset([], []).
subset([H|T1], [H|T2]) :-
    subset(T1, T2).
subset([_|T1], T2) :-
    subset(T1, T2).

sum([], 0).
sum([H|T], S) :-
    sum(T, S1),
    S is H + S1.

subsetsum(L, Sum, SubL) :-
    subset(L, SubL),
    sum(SubL, Sum).

% Exercise 7
% The maxCalories predicate on page 483 is rather ineffecient. In particular, the helper predicate maxC uses calories to compute the sum of the calories in a list of food items - and sometimes does so twice for the same list of food terms. Rewrite maxCalories and maxC to make them more efficient - in particular, make sure you eliminate the redundant computations of calories.
maxC([_], Sofar, MC, FirstC, Sofar) :-
    MC > FirstC.
maxC([First], _, MC, FirstC, First) :-
    MC =< FirstC.
maxC([First, Second|Rest], _, MC, FirstC, Result) :-
    MC =< FirstC,
    calories(Second, SecondC),
    maxC([Second|Rest], First, FirstC, SecondC, Result).
maxC([_, Second|Rest], Sofar, MC, FirstC, Result) :-
    MC > FirstC,
    calories(Second, SecondC),
    maxC([Second|Rest], Sofar, MC, SecondC, Result).

maxCalories([First, Second|Rest], Result) :-
    calories(First, FirstC),
    calories(Second, SecondC),
    maxC([Second|Rest], First, FirstC, SecondC, Result).

% Exercise 8
% Define a predicate multiknap(Pantry, Capacity, Knapsack) that works like the knapsackOptimization predicate from this chapter, but solves the multiple-choice knapsack problem. In this version of the problem you are allowed to take any number of each kind of item in the refridgerator.
subseqMK([], [], _, _).
subseqMK([food(N, W, C) | RestX], [food(N, W, C) | RestY], CurrCap, Cap) :-
    Temp is CurrCap + W,
    Temp =< Cap,
    subseqMK(RestX, RestY, Temp, Cap).
subseqMK([food(N, W, C) | RestX], [food(N, W, C) | RestY], CurrCap, Cap) :-
    Temp is CurrCap + W,
    Temp =< Cap,
    subseqMK(RestX, [food(N, W, C)|RestY], Temp, Cap).
subseqMK(X, [_|RestY], CurrCap, Cap) :-
    subseqMK(X, RestY, CurrCap, Cap).

calories([], 0).
calories([food(_, _, C) | Rest], X) :-
    calories(Rest, RestC),
    X is C + RestC.

legalKnapsack(Pantry, Capacity, Knapsack) :-
    subseqMK(Knapsack, Pantry, 0, Capacity).

multiknap(Pantry, Capacity, Knapsack) :-
    findall(K, legalKnapsack(Pantry, Capacity, K), L),
    maxCalories(L, Knapsack).

% Exercise 9
% WIP
