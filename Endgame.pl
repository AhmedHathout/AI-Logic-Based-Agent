% Load file KB1.pl. TRIED IT BUT IF USED THE PROGRAM DOES NOT TERMINATE.
% :- ['KB1'].
% Load file KB2.pl TRIED IT BUT IF USED THE PROGRAM DOES NOT TERMINATE.
% :- ['KB2'].

% --------------------------------------------------------------------------------

% KB 1
% Optimal Solution:-
% result(snap,result(right,result(collect, result(down,result(right,result(collect,result(right, result(collect,result(down,result(collect,result(left, s0))))))))))).

dimensions(5, 5).

thanos_location(3, 4).

stone(1, 1).
stone(2, 1).
stone(2, 2).
stone(3, 3).

iron_man_location(1, 2, [stone(1, 1), stone(2, 1), stone(2, 2), stone(3, 3)], s0).

% ---------------------------------------------------------------------------------

% KB 2
% Optimal Solution:-
% result(snap, result(down, result(left, result(left, result(left, result(collect, result(right, result(collect, result(right, result(collect, result(down, result(collect, result(left, s0))))))))))))),
%
% dimensions(4, 5).
%
% thanos_location(3, 0).
%
% stone(1, 1).
% stone(2, 1).
% stone(2, 2).
% stone(2, 3).
%
% iron_man_location(1, 2, [stone(1, 1), stone(2, 1), stone(2, 2), stone(2, 3)], s0).

% --------------------------------------------------------------------------------
% Main program
iron_man_location(I, J, Stones, result(A, S)):-
  (
    ( % He was not on the top border and he was one cell down
      A = up,
      I1 is I + 1,
      not(dimensions(I1, _)),
      iron_man_location(I1, J, Stones, S)
    );
    ( % He was not on the bottom border and he was one cell up
      A = down,
      I \= 0,
      I1 is I - 1,
      iron_man_location(I1, J, Stones, S)
    );
    ( % He was not on the left border and he was one cell to the right
      A = left,
      J1 is J + 1,
      not(dimensions(_, J1)),
      iron_man_location(I, J1, Stones, S)
    );
    ( % He was not on the right border and he was one cell to the left
      A = right,
      J \= 0,
      J1 is J - 1,
      iron_man_location(I, J1, Stones, S)
    )
  );
  ( % Iron Man did not change his location
    ( % Either Iron Man did not move or he was on the border
      (
        A = collect,
        stone(I, J),
        \+member(stone(I, J), Stones),
        select(stone(I, J), New_stones, Stones),
        iron_man_location(I, J, New_stones, S)
      );
      ( % Upper border
        iron_man_location(0, J, Stones, S),
        A = up
      );

      % Bottom border
      (
        iron_man_location(I, J, Stones, S),
        A = down,
        I1 is I + 1,
        dimensions(I1, _)
      );

      % Left border
      (
        iron_man_location(I, 0, Stones, S),
        A = left
      );

      % Right border
      (
        iron_man_location(I, J, Stones, S),
        A = right,
        J1 is J + 1,
        dimensions(_, J1)
      )
    )
  ).

snapped(result(snap, S)):-
  ( % Iron Man is in the same cell as Thanos and there are no stones left
    thanos_location(I, J),
    iron_man_location(I, J, [], S)
  ).

ids(Predicate, Initial_limit, Result):-
  (
    call_with_depth_limit(Predicate, Initial_limit, Result1),
    Result1 \= depth_limit_exceeded,
    Result = Result1
  );
  (
    New_limit is Initial_limit + 1,
    ids(Predicate, New_limit, Result)
  ).
