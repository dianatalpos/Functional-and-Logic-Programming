%generate all the mountains

%candidate2(l1,..ln)=(l1,l2,..,ln)
%                    (l, e, l2 ),when (e,l2)= candidate2(l2,..,ln)
%flow(i,o,o)
%candidate2(L-list, R-Integer, L2-list)
%
candidate2([H|T], H,T).
candidate2([H|T],E,[H|L2]):-candidate2(T,E,L2).

%final(L-list, D-integer, C-list, R-list)
%flow(i,i,i,o)
% final(l1,..,ln, d, c1,..cm)= final(L, 1, eUc), d=0, (e, L) =
%                                               candidate2(l1,..ln), e<c
%                              final(L,0, eUc),d=0,(e,L)= candidate2(l1,..ln)
%                                              e>c
%                              c, d=0
%                              f(L,1,eUc), d=1,
%                              (e,L)=candidate(l1,..,ln), e>c
final(L,D,[C1|C],R2):-candidate2(L,E,R), E<C1,D is 0, final(R,1,[E,C1|C], R2).
final(L,D,[C1|C],R2):-candidate2(L,E,R), E>C1,D is 0, final(R,0,[E,C1|C], R2).
final(L,D,[C1|C],R2):-candidate2(L,E,R), E<C1, D is 1 , final(R,1,[E,C1|C], R2).
final(_,1,C,C).

main([H|T],R):-candidate2([H|T], E1,L1), candidate2(L1, E2, L2), E1>E2,
                final(L2,0,[E1,E2], R).


wrapper(L,Res):-findall(R, main(L,R), Res).
