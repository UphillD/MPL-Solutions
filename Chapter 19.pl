% Exercise 1
% Define a mother predicate so that mother(X,Y) says that X is the mother of Y.
mother(X, Y) :-
    female(X),
    parent(X, Y).

% Exercise 2
% Define a father predicate so that father(X,Y) says that X is the father of Y.
father(X, Y) :-
    male(X),
    parent(X, Y).

% Exercise 3
% Define a sister predicate so that sister(X,Y) says that X is a sister of Y.
sister(X, Y) :-
    X \= Y,
    female(X),
    parent(Z, X),
    parent(Z, Y).

% Exercise 4
% Define a grandson predicate so that grandson(X,Y) says that X is a grandson of Y.
grandson(X, Y) :-
    male(X),
    parent(Z, X),
    parent(Y, Z).

% Exercise 5
% Define the firstCousin predicate so that firstCousin(X,Y) says that X is a first cousin of Y.
firstCousin(X, Y) :-
    X \= Y,
    parent(P1, X),
    parent(P2, Y),
    P1 \= P2,
    parent(Z, P1),
    parent(Z, P2).

% Exercise 6
% Define the descendant predicate so that descendant(X,Y) says that X is a descendant of Y.
descendant(X, Y) :-
    parent(Y, X).
descendant(X, Y) :-
    parent(Z, X),
    descendant(Z, Y).

% Exercise 7
% Define a third predicate so that third(X,Y) says that Y is the third element of the list X.
third([_, _, X|_], X).

% Exercise 8
% Define a firstPair predicate so that firstPair(X) succeeds if and only if X is a list of at least two elements, with the first element the same as the second element.
firstPair([X, X|_]).

% Exercise 9
% Define a del3 predicate so that del3(X,Y) says that the list Y is the same as the list X but with the third element deleted.
del3([A, B, C|T], [A, B|T]).

% Exercise 10
% Define a dupList predicate so that dupList(X,Y) says that X is a list and Y is the same list, but with each element of X repeated twice in a row.
dupList([], []).
dupList([H|Tx], [H, H|Ty]) :-
    dupList(Tx, Ty).

% Exercise 11
% Define a predicate isDuped so that isDuped(Y) succeeds if and only if Y is a list of the form of the lists Y in Exercise 10.
isDuped([]).
isDuped([X, X|T]) :-
    isDuped(T).

% Exercise 12
% Define the oddSize predicate so that oddSize(X) says that X is a list whose length is an odd number.
oddSize([_]).
oddSize([_, _|T]) :-
    oddSize(T).

% Exercise 13
% Define the evenSize predicate so that evenSize(X) says that X is a list whose length is an even number.
evenSize([_, _]).
evenSize([_, _|T]) :-
    evenSize(T).

% Exercise 14
% Define the prefix predicate so that prefix(X,Y) says that X is a list that is a prefix of Y.
prefix([], _).
prefix([H|Tx], [H|Ty]) :-
    prefix(Tx, Ty).

% Exercise 15
% Define the isMember predicate so that isMember(X,Y) says that element X is a member of set Y.
isMember(X, [X|_]).
isMember(X, [Y|T]) :-
    X \= Y,
    isMember(X, T).

% Exercise 16
% Define the isUnion predicate so that isUnion(X,Y,Z) says that the union of X and Y is Z.
isUnion([], [], []).
isUnion([], Y, Y).
isUnion([H|Tx], Y, [H|Tz]) :-
    isUnion(Tx, Y, Tz),
    \+ isMember(H, Y).
isUnion([H|Tx], Y, Z) :-
    isUnion(Tx, Y, Z),
    isMember(H, Y).

% Exercise 17
% Define the isIntersection predicate so that isIntersection(X,Y,Z) says that the intersection of X and Y is Z.
isIntersection([], _, []).
isIntersection([H|Tx], Y, [H|Tz]) :-
    isIntersection(Tx, Y, Tz),
    isMember(H, Y).
isIntersection([H|Tx], Y, Z) :-
   	isIntersection(Tx, Y, Z),
    \+ isMember(H, Y).

% Exercise 18
% Define the isEqual predicate so that isEqual(X,Y) says that the sets X and Y are equal.
isEqual([], _).
isEqual([H|T], Y) :-
    isMember(H, Y),
    isEqual(T, Y).

% Exercise 19
% Define the powerset predicate so that powerset(X,Y) says that the powerset of X is Y.
% WIP
