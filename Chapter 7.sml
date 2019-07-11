(* Exercise 2 *)
(* Define a function member of type ''a * ''a list -> bool so that member(e,L) is true if and only if e is an element of the list L. *)
fun member (n, []) = false
|   member (n, head::tail) = 
        if n = head then true
        else member (n, tail);

(* Exercise 3 *)
(* Define a function less of type int * int list -> int list so that less(e,L) is a list of all the integers in L that are less than e. *)
fun less (n, []) = []
|   less (n, head::tail) =
        if head < n then head::less (n, tail)
        else less (n, tail);

(* Exercise 4 *)
(* Define a function repeats of type ''a list -> bool so that repeats(L) is true if and only if the list L has two equal elements next to each other. *)
fun repeats [] = false
|   repeats [a] = false
|   repeats (a::b::tail) = 
        if a = b then true else repeats (b::tail);

(* Exercise 5 *)
(* Represent a polynomial using a list of its (real) coefficients, starting with the constant coefficient and going only as high as necessary. Write a function eval of type real list * real -> real that takes a polynomial represented this way and a value for x and returns the value of that polynomial as the given x. *)
fun eval ([], _) = 0.0
|   eval (head::tail, x) = 
        let
            fun evalHelper ([], _) = 0.0
            |   evalHelper (head::tail, x) =
                    x * head + evalHelper (tail, x * x);
        in
            head + evalHelper (tail, x)
        end;

(* Exercise 6 *)
(* Write a quicksort function of type int list -> int list. *)
fun quicksort [] = []
|   quicksort lst =
        let
            val pivot = hd lst
            fun quicksortSplit (_, [], less, more) = (less, more)
            |   quicksortSplit (pivot, head::tail, less, more) =
                if head < pivot then quicksortSplit (pivot, tail, head::less, more)
                else quicksortSplit (pivot, tail, less, head::more);
            val (less, more) = quicksortSplit (pivot, tl lst, [], [])
            val small = quicksort less
            val big = quicksort more
        in
            small@[pivot]@big
        end;

(* Exercise 7 *)
(* Make another version of your quicksort function, but this time of type 'a list * ('a * 'a -> bool) -> 'a list. The second parameter should be a function that performs the role of the < comparison in your original function. *)
fun quicksortEdited ([], _) = []
|   quicksortEdited (lst, operator) =
        let
            val pivot = hd lst
            fun quicksortSplit (_, [], less, more) = (less, more)
            |   quicksortSplit (pivot, head::tail, less, more) =
                if operator (head, pivot) then quicksortSplit (pivot, tail, head::less, more)
                else quicksortSplit (pivot, tail, less, head::more);
            val (less, more) = quicksortSplit (pivot, tl lst, [], [])
            val small = quicksortEdited (less, operator)
            val big = quicksortEdited (more, operator)
        in
            small@[pivot]@big
        end;

(* In the following exercises, implement sets as lists. *)
(* Exercise 8 *)
(* Write a function to test whether an element is a member of a set. *)
fun memberSet ([], _) = false
|   memberSet (head::tail, element) =
        if head = element then true
        else memberSet (tail, element);

(* Exercise 9 *)
(* Write a function to construct the union of two sets. *)
fun consUnion ([], set2) = set2
|   consUnion (set1, []) = set1
|   consUnion (set1, set2) =
        let
            fun unionHelper ([], [], union) = union
            |   unionHelper ([], head::tail, union) =
                    if memberSet (union, head) then unionHelper ([], tail, union)
                    else unionHelper([], tail, head::union)
            |   unionHelper (set1, set2, _) = unionHelper ([], set2, set1);
        in
            unionHelper (set1, set2, [])
        end;

(* Exercise 10 *)
(* Write a function to construct the intersection of two sets *)
fun consIntersection ([], set2) = []
|   consIntersection (set1, []) = []
|   consIntersection (set1, set2) =
        let
            fun intersectionHelper ([], _, intersection) = intersection
            |   intersectionHelper (head::tail, set2, intersection) =
                    if memberSet (set2, head) then intersectionHelper (tail, set2, head::intersection)
                    else intersectionHelper (tail, set2, intersection);
        in
            intersectionHelper (set1, set2, [])
        end;

(* Exercise 11 *)
(* Write a function to construct the powerset of any set. *)
fun consPowerset [] = [[]]
|   consPowerset (head::tail) =
        let
            fun powersetHelper ([], element) = [[]]
            |   powersetHelper ([]::tail, element) = [[element]]@powersetHelper (tail, element)
            |   powersetHelper (head::tail, element) = [head,head@[element]]@powersetHelper (tail, element);
        in
            powersetHelper (consPowerset tail, head)
        end;
