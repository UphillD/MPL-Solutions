% Exercise 6
/* 
 * This is a little adventure game. There are three
 * entities: you, a treasure, and an ogre. There are
 * six places: a valley, a path, a cliff, a fork, a maze,
 * and a mountaintop. Your goal is to get the treasure
 * without being killed first.
 */

% First, text descriptions of all the places in the game.
description(valley, 'You are in a pleasant valley, with a trail ahead.\n').
description(path, 'You are on a path, with ravines on both sides.\n').
description(cliff, 'You are teetering on the edge of a cliff.\n').
description(fork, 'You are at a fork in the path.\n').
description(maze(_), 'You are in a maze of twisty trails, all alike.\n').
description(mountaintop, 'You are on a mountaintop.\n').
description(gate, 'You are standing in front of a gate.\n').
description(gateTemp, '').

% report prints the description of your current location.
report :-
    at(you, X),
    description(X, Y),
    write(Y).

% These connect predicates establish the map.
connect(valley, forward, path).
connect(path, right, cliff).
connect(path, left, cliff).
connect(path, forward, fork).
connect(fork, left, maze(0)).
connect(fork, right, gate).
connect(gate, forward, gateTemp).
connect(gate, back, fork).
connect(maze(0), left, maze(1)).
connect(maze(0), right, maze(3)).
connect(maze(1), left, maze(0)).
connect(maze(1), right, maze(2)).
connect(maze(2), left, fork).
connect(maze(2), right, maze(0)).
connect(maze(3), left, maze(0)).
connect(maze(3), right, maze(3)).

% move(Dir) moves you in direction Dir, then prints the description of your new location.
move(Dir) :-
    at(you, Loc),
    connect(Loc, Dir, Next),
    retract(at(you, Loc)),
    assert(at(you, Next)),
    report,
    !.
% But if the argument was not a legal direction, print an error message and don't move.
move(_) :-
    write('That is not a legal move.\n'),
    report.

% Shorthand for moves.
forward :- move(forward).
left :- move(left).
right :- move(right).
back :- move(back).

% If you and the ogre are at the same place, it kills you.
ogre :-
    at(ogre, Loc),
    at(you, Loc),
    write('An ogre sucks your brain out through\n'),
    write('your eye sockets, and you die.\n'),
    retract(at(you, Loc)),
    assert(at(you, done)),
    !.
% But if you and the ogre are not in the same place, nothing happens.
ogre.

% If you and the treasure are at the same place, you win.
treasure :-
    at(treasure, Loc),
    at(you, Loc),
    write('There is a treasure here.\n'),
    write('Congratulations, you win!\n'),
    retract(at(you, Loc)),
    assert(at(you, done)),
    !.
% But if you and the treasure are not in the same place, nothing happens.
treasure.

% If you are at the cliff, you fall off and die.
cliff :-
    at(you, cliff),
    write('You fall of and die.\n'),
    retract(at(you, cliff)),
    assert(at(you, done)),
    !.
% But if you are not at the cliff nothing happens.
cliff.

% If you and the key are at the same place, you see it.
key :-
    at(you, Loc),
    at(key, Loc),
    write('You see a key on the floor.\n'),
    !.
% But if you are not, nothing happens.
key.

gate :-
    at(you, gateTemp),
    \+ at(key, inv),
    unlocked(gate),
    retract(at(you, gateTemp)),
    assert(at(you, mountaintop)),
    !.
gate :-
    at(you, gateTemp),
    \+ unlocked(gate),
    write('You need to unlock the gate first.\n'),
    retract(at(you, gateTemp)),
    assert(at(you, gate)),
    !.
gate :-
    at(you, gateTemp),
    unlocked(gate),
    at(key, inv),
    write('You are struck by lightning.\n'),
    retract(at(you, gateTemp)),
    assert(at(you, done)),
    !.
gate.


unlock :-
    at(you, gate),
    at(key, inv),
    \+ unlocked(gate),
    write('You unlock the gate.\n'),
    assert(unlocked(gate)),
    !.
unlock :-
    at(you, gate),
    \+ at(key, inv),
    \+ unlocked(gate),
    write('You need a key to do that.\n'),
    !.
unlock :-
    at(you, gate),
    unlocked(gate),
    write('The gate is already unlocked!\n'),
    !.
unlock.  

pickup :-
    at(you, Loc),
    at(key, Loc),
    write('You pick the key up.\n'),
    retract(at(key, Loc)),
    assert(at(key, inv)).
pickup :-
    write('There is nothing to pick up.\n').

throwaway :-
    at(you, Loc),
    at(key, inv),
    write('You throw the key away.\n'),
    retract(at(key, inv)),
    assert(at(key, Loc)).
throwaway :-
    write('There is nothing to throw away.\n').

/*
 * Main loop. Stop if player won or lost.
 */
main :-
    at(you, done),
    write('Thanks for playing.\n'),
    !.
/*
 * Main loop. Not done, so get a move from the user
 * and make it. Then run all our special behaviors.
 * Then repeat.
 */
main :-
    write('\nNext move - '),
    read(Move),
    call(Move),
    ogre,
    gate,
    treasure,
    cliff,
    key,
    main.

/*
 * This is the starting point for the game. We
 * assert the initial conditions, print an initial
 * report, then start the main loop.
 */
go :-
    retractall(at(_, _)), % clean up from previous runs
    retractall(unlocked(_)),
    assert(at(you, valley)),
    assert(at(ogre, maze(3))),
    assert(at(treasure, mountaintop)),
    assert(at(key, maze(2))),
    write('This is an adventure game. \n'),
    write('Legal moves are left, right, or forward.\n'),
    write('End each move with a period.\n\n'),
    report,
    main.
