%a. Define a predicate to determine the longest sequences of consecutive
% even numbers (if exist more maximal sequences one of them)

%noOfelem(L:list, R:int)
%flow(i,o)
%noOfelem(l1,..ln)= 0, n=0
%                   1+noOfelem(l2,..ln), n!=0
noOfelem([],0).
noOfelem([_|T],R):- noOfelem(T, R1), R is R1+1.


%isLonger(L1:list, L2:list, R list)
%flow(i,i,o)
%isLonger(a1,a2..,an,b1,b2..,bm) = a1,...,an, m>=n
%                                  b1,..,bm, otherwise

isLonger(L1,L2,R):- noOfelem(L1,R1), noOfelem(L2,R2), R1>R2, R=L1.
isLonger(L1,L2, R):- noOfelem(L1,R1), noOfelem(L2,R2), R1<R2, R=L2.
isLonger(L1,L2, R):- noOfelem(L1,R1), noOfelem(L2,R2), R1=:=R2, R=L1.


%verify(L:list, P:list, R:list)
%flow(i,o,o)
%verify(l1,..ln)= verify(l2,...ln), l1 is odd,
%                 l1 U verify(l2,..,ln, l1) a,b even,a<b
%                 verify(l2,...,ln) l1 even , l2 odd, or l1, l2 even
%                                     l1>l2
%                     ,  n=0
verify([A|[]],[A],[A]):-A mod 2 =:= 0,!.
verify([_|[]],[],[]).
verify([A,B|C],L,R):-verify([B|C],L1,R2),A mod 2 =:= 0,A<B,B mod 2 =:=0,L=[A|L1], isLonger(L,R2,R),!.
verify([A,B|C],L,R):-verify([B|C],_,R2),A mod 2 =:= 0,(A<B,B mod 2 =:= 1;A>B), L=[A],isLonger(L,R2,R),!.
verify([A,B|C],_,R):-verify([B|C],_,R),A mod 2 =:= 1,!.


wrapper([],[]):-!.
wrapper(L,R):-verify(L,_,R),!.


%b. For a heterogeneous list, formed from integer numbers and list of numbers,
%define a predicate to replace
% every sublist with the longest sequences of even numbers from thatsublist.

%modify(L:list, R:list)
%flow(i,o)
%modify(l1,..,ln) = wrapper(l1), if  n=1, l1- list
%                   l1, n=1, l1- number
%                   modify(l2,..,ln) U wrapper(l1), l1-list
%                   mofify(l2,...,ln) U l1, l1- number

modify([A|[]], R):- is_list(A), wrapper(A, R1), R=[R1],!.
modify([A|[]], R):- number(A), R=[A].
modify([A|T], R):- modify(T,Rs), is_list(A), wrapper(A,R1), R=[R1|Rs], !.
modify([H|T], R):- modify(T,Rs), R=[H|Rs].


writing([A|[]]):- write(A).
writing([H|T]):- write(H),writing(T).


final(L):- modify(L,R), writing(R).







