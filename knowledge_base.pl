/***************************
File:        knowledge_base.pl (2/3)
Author:      Rutvij Shah
Net ID:      rds190000
Class:       AI CS 4365.002
Project:     Knowledge Representation
Description: Prolog FOL Axioms & Rules.
***************************/

bakery(utdBakery).

place(X) :- bakery(X).

person(john).
person(mary).

sells(Y, X) :- food(X), in_stock(Y, X).

utility_of_x_for_y(X, Y, use) :- electronics(X), person(Y).
utility_of_x_for_y(X, Y, eat) :- food(X), person(Y).



baked_list([
  buns, bagels, bread, cinnamon_rolls,
  doughnuts, cookies, muffins, scones
  ]).

fruit_list([
  apples, bananas
]).

brewed_list([
  coffee
]).

food(X) :- baked_list(Y), member(X, Y).
food(X) :- fruit_list(Y), member(X, Y).
food(X) :- brewed_list(Y), member(X, Y).

source(X, baked_in_house) :- baked_list(Y), member(X, Y).
source(X, bought) :- fruit_list(Y), member(X, Y).
source(X, brewed) :- brewed_list(Y), member(X, Y).

electronics(tv).

:- dynamic stock/3.
:- dynamic has/3.
:- dynamic money/2.
:- dynamic visited/4.

stock(utdBakery, apples, 200).
stock(utdBakery, buns, 200).
stock(utdBakery, bananas, 200).
stock(utdBakery, bagels, 200).
stock(utdBakery, bread, 200).
stock(utdBakery, cinnamon_rolls, 200).
stock(utdBakery, doughnuts, 200).
stock(utdBakery, coffee, 200).
stock(utdBakery, cookies, 200).
stock(utdBakery, muffins, 200).
stock(utdBakery, scones, 200).

money(john, 100).
money(utdBakery, 1000).
money(mary, 120).

has_cash(X) :- money(X, Y), Y > 0.
has_credit_card(X) :- money(X, Y), Y > 0.

in_stock(StoreName, Product) :-
  stock(StoreName, Product, Quantity),
  Quantity > 0.

sell(StoreName, Product, SellQuantity, Income) :-
  in_stock(StoreName, Product),
  stock(StoreName, Product, OldQuantity),
  NewQuantity is OldQuantity - SellQuantity,
  retract(stock(StoreName, Product, OldQuantity)),
  assert(stock(StoreName, Product, NewQuantity)),
  retract(money(StoreName, CurrentAmount)),
  NewAmount is CurrentAmount + Income,
  assert(money(StoreName, NewAmount)).

buy(Person, Item, BuyQuantity, Cost) :-
  (has(Person, Item, CurrenQuantity) ->
    %if
    retract(has(Person, Item, CurrenQuantity)),
    NewQuantity is CurrenQuantity + BuyQuantity,
    assert(has(Person, Item, NewQuantity));
    %else
    assert(has(Person, Item, BuyQuantity))
  ),
  retract(money(Person, CurrentAmount)),
  NewAmount is CurrentAmount - Cost,
  assert(money(Person, NewAmount)).

sub_transaction(Person, StoreName, Product, ItemQuantityRaw, Cost) :-
  quantityIs(ItemQuantityRaw, ItemQuantity),
  sell(StoreName, Product, ItemQuantity, Cost),
  buy(Person, Product, ItemQuantity, Cost).

/*
visited(john,
  utdBakery,
  date(2021, 11, 16, 8, 30, 0, 0, -, -),
  date(2021, 11, 16, 8, 37, 0, 0, -, -)).

visited(mary,
  utdBakery,
  date(2021, 11, 16, 6, 30, 0, 0, -, -),
  date(2021, 11, 16, 8, 32, 0, 0, -, -)).


assert(visited(mary,
  utdBakery,
  date(2021, 11, 16, 6, 30, 0, 0, -, -),
  date(2021, 11, 16, 8, 32, 0, 0, -, -))).
*/

duration_of_visit(Person, Place, Duration) :-
  visited(Person, Place,
    date(_, _, _, H1, M1, _, _, _, _),
    date(_, _, _, H2, M2, _, _, _, _)),
  Duration is (H2-H1)*60 + M2-M1.

met(Person1, Person2, Place) :-
  visited(Person1, Place,
    date(Y, M, D, H1_s, M1_s, _, _, _, _),
    date(Y, M, D, H1_e, M1_e, _, _, _, _)
    ),
  visited(Person2, Place,
    date(Y, M, D, H2_s, M2_s, _, _, _, _),
    date(Y, M, D, H2_e, M2_e, _, _, _, _)
    ),
  T1_s is H1_s*60 + M1_s,
  T1_e is H1_e*60 + M1_e,
  T2_s is H2_s*60 + M2_s,
  T2_e is H2_e*60 + M2_e,
  (
    (T1_s < T2_s, T2_s < T1_e, T1_e < T2_e);
    (T2_s < T1_s, T1_s < T2_e, T2_e < T1_e)
    ).


string_to_atom("dozen", 12).
string_to_atom("couple", 2).
string_to_atom("score", 20).
string_to_atom("loaf", 1).

quantityIs(X, Z) :-
  string(X) ->
    string_to_atom(X, Z);
    Z is X.
