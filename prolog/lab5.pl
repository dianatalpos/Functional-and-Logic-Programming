%Prolog3 inlocuirea elementelor de pe pozitii pare cu diferenta
%dintre minimul listei si elementul 

%minim(L: list, A-integer, Min-integer)
%flow(i,i,o)
%minim(l1,..,ln, a)= minim(l2,...,ln, a) , a<l1, n!=0
%                    minim(l2,...,ln, l1), l1<a, n!=0
%                    a, n=0
minim([], A, A).
minim([H|T],A, Min):- H<A, minim(T, H, Min),!.
minim([_|T], A, Min):-minim(T, A, Min).

%modify(L: list, Min-integer, R-list)
%flow(i,i,o)
%modify(l1,..,ln,min)= l1, if n = 1
%                      [], if n = 0
%                      l1 U l2-min U modify(l3,..,ln), otherwise


modify([],_, []).
modify([A], _, [A]).
modify([A,B|T], Min, R):- N is B-Min, modify(T, Min, Rs), R=[A,N|Rs],!.

%main(L:list)
%flow(i)

main([]):-write([]),!.
main(L):- [A|_]=L, minim(L,A,Min), modify(L, Min, R), write(R),!.


%insert(L:list, R:list)
%flow(i,o)
%insert(l1,..,ln)=   , n=0
%                  99 U l1 U insert(l2,...,ln), l1 odd, n!=0
%                  l1U insert(l2,...,ln), l1 even, n!=0
insert([], []):-!.
insert([H|T], R):- (H mod 2)=:=1, insert(T, Rs),X is 99, R = [X,H|Rs],!.
insert([H|T], R):- insert(T, Rs), R=[H|Rs].

%flow(i)
main2(L):- insert(L, R), write(R).

