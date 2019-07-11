(* Exercise 1 *)
(* Write a function cube of type int -> int that returns the cube of its parameter. *)
fun cube n = n * n * n;

(* Exercise 2 *)
(* Write a function cuber of type real -> real that returns the cube of its parameter. *)
fun cuber n:real = n * n * n;

(* Exercise 3 *)
(* Write a function fourth of type 'a list -> 'a that returns the fourth element of a list. *)
fun fourth lst = hd(tl(tl(tl(lst))));

(* Exercise 4 *)
(* Write a function min3 of type int * int * int -> int that returns the smallest of three integers. *)
fun min3 (a, b, c) = 
    if a < b then
        if a < c then a else c
    else
        if b < c then b else c;

(* Exercise 5 *)
(* Write a function red3 of type 'a * 'b * 'c -> 'a * 'c that converts a tuple with three elements into one with two by eliminating the second element. *)
fun red3 (a, b, c) = (a, c);

(* Exercise 6 *)
(* Write a function thirds of type string -> char that returns the third character of a string. *)
fun thirds str = hd(tl(tl(explode str)));

(* Exercise 7 *)
(* Write a function cycle1 of type 'a list -> 'a list whose output list is the same as the input list, but with the first element of the list moved to the end. For example, cycle1 [1,2,3,4] should return [2,3,4,1]. *)
fun cycle1 lst = tl lst@[hd lst];

(* Exercise 8 *)
(* Write a function sort3 of type real * real * real -> real list that returns a list of three real numbers, in sorted order with the smallest first. *)
fun sort3 (a:real, b:real, c:real) = 
    if a < b andalso a < c then
        if b < c then [a, b, c]
        else [a, c, b]
    else if b < c andalso b < a then
        if c < a then [b, c, a]
        else [b, a, c]
    else
        if a < b then [c, a, b]
        else [c, b, a];

(* Exercise 9 *)
(* Write a function del3 of type 'a list -> 'a list whose output list is the same as the input list, but with the third element deleted. *)
fun del3 (a::b::c::tail) = a::b::tail
|   del3 lst = lst;

(* Exercise 10 *)
(* Write a function sqsum of type int -> int that takes a non-negative integer n and returns the sum of the squares of all the integers 0 through n. *)
fun sqsum 0 = 1
|   sqsum n = n * n * sqsum (n - 1);

(* Exercise 11 *)
(* Write a function cycle of type 'a list * int -> 'a list that takes a list and an integer n as input and returns the same list, but with the first element cycled to the end of the list n times. *)
fun cycle (lst, 0) = lst
|   cycle (lst, n) = cycle (cycle1 lst, n - 1);

(* Exercise 12 *)
(* Write a function pow of type real * int -> real that raises a real number to an integer power. *)
fun pow (x:real, 0) = 1.0
|   pow (x:real, y) = x * pow (x, y - 1);

(* Exercise 13 *)
(* Write a function max of type int list -> int that returns the largest element of a list of integers. *)
fun max lst = 
    let
        fun maxHelper ([], max) = max
        |   maxHelper ((head::tail), max) = 
                if head > max then maxHelper (tail, head)
                else maxHelper (tail, max);
    in
        maxHelper (tl lst, hd lst)
    end;

(* Exercise 14 *)
(* Write a function isPrime of type int -> bool that returns true if and only if its integer parameter is a prime number. *)
fun isPrime 1 = false
|   isPrime n = 
        let
            fun isPrimehelper (n, 1) = true
            |   isPrimehelper (n, divider) =
                    if n mod divider = 0 then false
                    else isPrimehelper (n, divider - 1);
        in
            isPrimehelper(n, n div 2)
        end;

(* Exercise 15 *)
(* Write a function select of type 'a list * ('a -> bool) -> 'a list that takes a list and a function f as parameters. Your function should apply f to each element of the list and should return a new list containing only those elements of the original list for which f returned true. *)
fun select ([], _) = []
|   select ((head::tail), f) = 
        if f head then head::select (tail, f)
        else select (tail, f);
