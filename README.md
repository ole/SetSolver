# SetSolver package

## Products

- SetSolver: A library that provides types to model the card game
  [Set](https://en.wikipedia.org/wiki/Set_%28card_game%29) in Swift, and a
  solver for the game.
  
- SetUI: A library that provides SwiftUI views for rendering Set cards.

## Card notation

Each card can be represented as a four-character string in the order
number–symbol–color–shading. Examples:

- 1Dp■ = one diamond purple solid
- 2Sg▥ = two squiggles green striped
- 3Or□ = three ovals red no-fill (outlined)

## Snippets

Simulate a one-player game of Set:

```sh
swift run Play
```

Sample output:

```
Starting game with shuffled deck

Remaining cards | 12 open, 69 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 1
Open cards      | 1Dp■ 1Op□ 1Sr□ 1Sg▥ 1Sp■ 2Or▥ 2Og■ 2Og▥ 2Sp□ 3Dp□ 3Sg□ 3Sp▥
Found set       | 1Sr□ 2Sp□ 3Sg□
New cards       | 1Or▥ 3Dg▥ 3Or■
Remaining cards | 12 open, 66 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 2
Open cards      | 1Dp■ 1Or▥ 1Op□ 1Sg▥ 1Sp■ 2Or▥ 2Og■ 2Og▥ 3Dg▥ 3Dp□ 3Or■ 3Sp▥
Found set       | 1Op□ 2Og▥ 3Or■
New cards       | 2Or□ 2Sp■ 3Op□
Remaining cards | 12 open, 63 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 3
Open cards      | 1Dp■ 1Or▥ 1Sg▥ 1Sp■ 2Or▥ 2Or□ 2Og■ 2Sp■ 3Dg▥ 3Dp□ 3Op□ 3Sp▥
Found set       | 1Or▥ 2Og■ 3Op□
New cards       | 1Dg■ 2Dg■ 3Or▥
Remaining cards | 12 open, 60 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 4
Open cards      | 1Dg■ 1Dp■ 1Sg▥ 1Sp■ 2Dg■ 2Or▥ 2Or□ 2Sp■ 3Dg▥ 3Dp□ 3Or▥ 3Sp▥
Found set       | 3Dg▥ 3Or▥ 3Sp▥
New cards       | 2Dp□ 2Op▥ 3Or□
Remaining cards | 12 open, 57 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 5
Open cards      | 1Dg■ 1Dp■ 1Sg▥ 1Sp■ 2Dg■ 2Dp□ 2Or▥ 2Or□ 2Op▥ 2Sp■ 3Dp□ 3Or□
Found set       | 1Sp■ 2Op▥ 3Dp□
New cards       | 1Op■ 1Sp▥ 2Dr□
Remaining cards | 12 open, 54 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 6
Open cards      | 1Dg■ 1Dp■ 1Op■ 1Sg▥ 1Sp▥ 2Dr□ 2Dg■ 2Dp□ 2Or▥ 2Or□ 2Sp■ 3Or□
Found set       | 1Sp▥ 2Dg■ 3Or□
New cards       | 2Dg▥ 3Dr▥ 3Dp■
Remaining cards | 12 open, 51 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 7
Open cards      | 1Dg■ 1Dp■ 1Op■ 1Sg▥ 2Dr□ 2Dg▥ 2Dp□ 2Or▥ 2Or□ 2Sp■ 3Dr▥ 3Dp■
Found set       | 1Op■ 2Sp■ 3Dp■
New cards       | 1Dr▥ 1Sr■ 2Op□
Remaining cards | 12 open, 48 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 8
Open cards      | 1Dr▥ 1Dg■ 1Dp■ 1Sr■ 1Sg▥ 2Dr□ 2Dg▥ 2Dp□ 2Or▥ 2Or□ 2Op□ 3Dr▥
Found set       | 1Dg■ 2Dp□ 3Dr▥
New cards       | 2Sg■ 2Sg□ 3Op▥
Remaining cards | 12 open, 45 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 9
Open cards      | 1Dr▥ 1Dp■ 1Sr■ 1Sg▥ 2Dr□ 2Dg▥ 2Or▥ 2Or□ 2Op□ 2Sg■ 2Sg□ 3Op▥
Found set       | 2Dr□ 2Op□ 2Sg□
New cards       | 2Sg▥ 3Dg□ 3Sg▥
Remaining cards | 12 open, 42 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 10
Open cards      | 1Dr▥ 1Dp■ 1Sr■ 1Sg▥ 2Dg▥ 2Or▥ 2Or□ 2Sg■ 2Sg▥ 3Dg□ 3Op▥ 3Sg▥
Found set       | 1Dr▥ 2Sg▥ 3Op▥
New cards       | 1Dr□ 1Sr▥ 3Sp□
Remaining cards | 12 open, 39 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 11
Open cards      | 1Dr□ 1Dp■ 1Sr■ 1Sr▥ 1Sg▥ 2Dg▥ 2Or▥ 2Or□ 2Sg■ 3Dg□ 3Sg▥ 3Sp□
Found set       | 1Dp■ 2Or□ 3Sg▥
New cards       | 1Dr■ 3Dg■ 3Og▥
Remaining cards | 12 open, 36 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 12
Open cards      | 1Dr■ 1Dr□ 1Sr■ 1Sr▥ 1Sg▥ 2Dg▥ 2Or▥ 2Sg■ 3Dg■ 3Dg□ 3Og▥ 3Sp□
Found set       | 1Sg▥ 2Dg▥ 3Og▥
New cards       | 1Og■ 3Dp▥ 3Op■
Remaining cards | 12 open, 33 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 13
Open cards      | 1Dr■ 1Dr□ 1Og■ 1Sr■ 1Sr▥ 2Or▥ 2Sg■ 3Dg■ 3Dg□ 3Dp▥ 3Op■ 3Sp□
Found set       | 1Og■ 2Sg■ 3Dg■
New cards       | 1Og▥ 1Og□ 2Dp▥
Remaining cards | 12 open, 30 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 14
Open cards      | 1Dr■ 1Dr□ 1Og▥ 1Og□ 1Sr■ 1Sr▥ 2Dp▥ 2Or▥ 3Dg□ 3Dp▥ 3Op■ 3Sp□
Found set       | 1Og□ 2Or▥ 3Op■
New cards       | 1Op▥ 2Sr▥ 3Sp■
Remaining cards | 12 open, 27 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 15
Open cards      | 1Dr■ 1Dr□ 1Og▥ 1Op▥ 1Sr■ 1Sr▥ 2Dp▥ 2Sr▥ 3Dg□ 3Dp▥ 3Sp■ 3Sp□
Found set       | 1Dr■ 2Dp▥ 3Dg□
New cards       | 1Dp▥ 2Dg□ 3Og■
Remaining cards | 12 open, 24 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 16
Open cards      | 1Dr□ 1Dp▥ 1Og▥ 1Op▥ 1Sr■ 1Sr▥ 2Dg□ 2Sr▥ 3Dp▥ 3Og■ 3Sp■ 3Sp□
Found set       | 1Og▥ 2Sr▥ 3Dp▥
New cards       | 1Or□ 2Dr▥ 3Og□
Remaining cards | 12 open, 21 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 17
Open cards      | 1Dr□ 1Dp▥ 1Or□ 1Op▥ 1Sr■ 1Sr▥ 2Dr▥ 2Dg□ 3Og■ 3Og□ 3Sp■ 3Sp□
Found set       | 1Or□ 2Dg□ 3Sp□
New cards       | 2Sr□ 3Dr■ 3Sr□
Remaining cards | 12 open, 18 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 18
Open cards      | 1Dr□ 1Dp▥ 1Op▥ 1Sr■ 1Sr▥ 2Dr▥ 2Sr□ 3Dr■ 3Og■ 3Og□ 3Sr□ 3Sp■
Found set       | 1Dp▥ 2Sr□ 3Og■
New cards       | 1Dg▥ 2Or■ 3Sg■
Remaining cards | 12 open, 15 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 19
Open cards      | 1Dr□ 1Dg▥ 1Op▥ 1Sr■ 1Sr▥ 2Dr▥ 2Or■ 3Dr■ 3Og□ 3Sr□ 3Sg■ 3Sp■
Found set       | 1Sr■ 2Or■ 3Dr■
New cards       | 2Sp▥ 3Dr□ 3Sr■
Remaining cards | 12 open, 12 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 20
Open cards      | 1Dr□ 1Dg▥ 1Op▥ 1Sr▥ 2Dr▥ 2Sp▥ 3Dr□ 3Og□ 3Sr■ 3Sr□ 3Sg■ 3Sp■
Found set       | 1Dg▥ 1Op▥ 1Sr▥
New cards       | 1Sg■ 2Dp■ 2Op■
Remaining cards | 12 open, 9 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 21
Open cards      | 1Dr□ 1Sg■ 2Dr▥ 2Dp■ 2Op■ 2Sp▥ 3Dr□ 3Og□ 3Sr■ 3Sr□ 3Sg■ 3Sp■
Found set       | 1Sg■ 2Sp▥ 3Sr□
New cards       | 1Or■ 2Dr■ 3Sr▥
Remaining cards | 12 open, 6 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 22
Open cards      | 1Dr□ 1Or■ 2Dr■ 2Dr▥ 2Dp■ 2Op■ 3Dr□ 3Og□ 3Sr■ 3Sr▥ 3Sg■ 3Sp■
Found set       | 1Or■ 2Dp■ 3Sg■
New cards       | 1Dp□ 1Sp□ 2Sr■
Remaining cards | 12 open, 3 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 23
Open cards      | 1Dr□ 1Dp□ 1Sp□ 2Dr■ 2Dr▥ 2Op■ 2Sr■ 3Dr□ 3Og□ 3Sr■ 3Sr▥ 3Sp■
Found set       | (none)
New cards       | 1Dg□ 1Sg□ 2Og□
Remaining cards | 15 open, 0 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 24
Open cards      | 1Dr□ 1Dg□ 1Dp□ 1Sg□ 1Sp□ 2Dr■ 2Dr▥ 2Og□ 2Op■ 2Sr■ 3Dr□ 3Og□ 3Sr■ 3Sr▥ 3Sp■
Found set       | 1Dr□ 1Dg□ 1Dp□
Remaining cards | 12 open, 0 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 25
Open cards      | 1Sg□ 1Sp□ 2Dr■ 2Dr▥ 2Og□ 2Op■ 2Sr■ 3Dr□ 3Og□ 3Sr■ 3Sr▥ 3Sp■
Found set       | 1Sp□ 2Og□ 3Dr□
Remaining cards | 9 open, 0 in deck
————————————————————————————————————————————————————————————————————
Move no.        | 26
Open cards      | 1Sg□ 2Dr■ 2Dr▥ 2Op■ 2Sr■ 3Og□ 3Sr■ 3Sr▥ 3Sp■
No sets left, game over
```
