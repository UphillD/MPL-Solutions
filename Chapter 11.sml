(* Exercise 1 *)
(* Write a datatype definition for a type suit whose values are the four suits of a deck of playing cards. *)
datatype suit = clubs | diamonds | hearts | spades;

(* Exercise 2 *)
(* Using your definition from Exercise 1, write a function suitname of type suit -> string that returns a string giving the name of a suit. *)
fun suitname clubs = "clubs"
|   suitname diamonds = "diamonds"
|   suitname hearts = "hearts"
|   suitname spades = "spades";

(* Exercise 3 *)
(* Write a datatype definition for a type number whose values are either integers or real numbers *)
datatype number = INT of int | REAL of real;

(* Exercise 4 *)
(* Using your definition from Exercise 3, write a function plus of type number -> number -> number that adds two numbers, coercing int to real only if necessary. *)
fun plus (INT x) (INT y) = INT (x + y)
|   plus (INT x) (REAL y) = REAL (real x + y)
|   plus (REAL x) (INT y) = REAL (x + real y)
|   plus (REAL x) (REAL y) = REAL (x + y);

(* Exercise 5 *)
(* Write a function addup of type intnest -> int that adds up all the integers in an intnest. *)
datatype intnest =
    INT of int |
    LIST of intnest list;

fun addup (INT x) = x
|   addup (LIST []) = 0
|   addup (LIST ((INT head)::tail)) = head + addup (LIST tail);

(* Exercise 6 *)
(* Write a function prod of type int mylist -> int that takes an int mylist x and returns the product of all the elements of x. If the list is NIL your function should return 1 *)
datatype 'element mylist =
    NIL |
    CONS of 'element * 'element mylist;

fun prod NIL = 1
|   prod (CONS (head, tail)) = head * prod (tail);

(* Exercise 7 *)
(* Write a function reverse of type 'a mylist -> 'a mylist that takes a mylist a and returns a mylist of all the elements of a, in reverse order. *)
fun reverse NIL = NIL
|   reverse (CONS (head, tail)) =
        let
            fun reverseHelper (NIL, NIL) = NIL
            |   reverseHelper (CONS (head, tail), NIL) = CONS (head, tail)
            |   reverseHelper (NIL, CONS (head, tail)) = CONS (head, tail)
            |   reverseHelper (CONS (head1, tail1), CONS (head2, tail2)) =
                    reverseHelper (CONS (head2, CONS (head1, tail1 )), tail2);
        in
            reverseHelper (CONS (head, NIL), tail)
        end;

(* Exercise 8 *)
(* Write a function append of type 'a mylist -> 'a mylist -> 'a mylist that takes two mylist values, a and b, and returns the mylist containing all the elements of a followed by all the elements of b. *)
fun append NIL NIL = NIL
|   append NIL (CONS (head, tail)) = CONS (head, tail)
|   append (CONS (head, tail)) NIL = CONS (head, tail)
|   append (CONS (head1, tail1)) (CONS (head2, tail2)) =
        append (tail1) (CONS (head1, (CONS (head2, tail2))));

(* Exercise 9 *)
(* Write a function appendall of type 'a list tree -> 'a list that takes a tree of lists and returns the result of appending all the lists together. *)
datatype 'data tree =
    Empty |
    Node of 'data tree * 'data * 'data tree;

fun appendall Empty = []
|   appendall (Node (l, x, r)) = appendall (l) @ [x] @ appendall (r);

(* Exercise 10 *)
(* Write a function isComplete of type 'a tree -> bool that tests whether a tree is complete. *)
fun isComplete Empty = true
|   isComplete (Node (Node (l, x, r), n, Empty)) = false
|   isComplete (Node (Empty, n, Node (l, x, r))) = false
|   isComplete (Node (l, x, r)) = isComplete (l) andalso isComplete (r);

(* Exercise 11 *)
(* Write a function makeBST of type 'a list -> ('a * 'a -> bool) -> 'a tree that organizes the items in the list into a binary search tree. *)
fun makeBST [] _ = Empty
|   makeBST [x] _ = Node (Empty, x, Empty)
|   makeBST (a::b::tail) operator =
        if operator (a, b) then Node (Empty, a, makeBST (b::tail) operator)
        else Node (makeBST (a::tail) operator, b, Empty);

(* Exercise 12 *)
(* Write a function searchBST of type ''a tree -> (''a * ''a -> bool) -> ''a -> bool that searches a binary search tree for a given data element. *)
fun searchBST (Empty) _ e = false
|   searchBST (Node (l, x, r)) operator e =
        if e = x then true
        else if operator (e, x) then searchBST (l) operator e
        else searchBST (r) operator e;