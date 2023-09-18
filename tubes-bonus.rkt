;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname tubes-bonus) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "tubes-lib.rkt")

;; A Game is (make-game Nat Nat (listof (listof Sym)))
(define-struct game (tubesize maxcolours tubes))

;;; Constants

(define emptygame
  (make-game 0 5
             (list empty empty empty empty empty)))

(define emptygame2
  (make-game 10 3 empty))

(define emptygame3
  (make-game 10 3 (list empty empty)))

(define smallgame1
  (make-game 2 2
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))

(define smallgame2
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))

(define smallinvalidgame1
  (make-game 2 1
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))


(define smallinvalidgame2
  (make-game 2 2
             (list (list 'blue 'red)
                   (list 'blue 'blue)
                   (list))))

(define smallinvalidgame3
  (make-game 2 2
             (list (list 'blue 'red 'blue)
                   (list 'red)
                   (list))))


(define smallgamefinal
  (make-game 2 2
             (list (list)
                   (list 'blue 'blue)
                   (list 'red 'red))))


(define mediumgame
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'red 'yellow)
                   (list 'yellow 'blue)
                   (list))))

(define mediumgamestuck
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'red 'yellow)
                   (list 'yellow 'blue)
                   )))

(define largergame
  (make-game 3 3
             (list (list 'blue 'red 'red)
                   (list 'yellow 'blue 'yellow)
                   (list 'red 'yellow 'blue)
                   (list))))

(define biggame
  (make-game 5 3
             (list (list 'blue 'blue 'red 'red 'yellow)
                   (list 'red 'red 'yellow 'blue 'red)
                   (list 'yellow 'blue 'blue 'yellow 'yellow)
                   (list)
                   (list))))

(define biggame2
  (make-game 5 3
             (list (list 'yellow 'blue 'blue 'yellow 'yellow)
                   (list 'red 'red 'yellow 'blue 'red)
                   (list)
                   (list 'blue 'blue 'red 'red 'yellow)
                   (list))))

(define biggamesolve
  (make-game 5 3
             (list (list 'blue 'blue 'blue 'blue 'blue)
                   (list 'red 'red 'red 'red 'red)
                   (list 'yellow 'yellow 'yellow 'yellow 'yellow)
                   (list)
                   (list))))

(define hugegame
  (make-game 4 9
             (list (list 'purple 'pink 'yellow 'blue)
                   (list 'blue 'green 'purple 'white)
                   (list 'orange 'yellow 'black 'blue)
                   (list 'white 'orange 'orange 'pink)
                   (list 'pink 'red 'red 'black)
                   (list 'yellow 'green 'orange 'blue)
                   (list 'white 'purple 'red 'yellow)
                   (list 'green 'red 'green 'black)
                   (list 'purple 'black 'white 'pink)
                   (list)
                   (list))
             ))

(define hugegame2
  (make-game 4 9
             (list (list 'purple 'pink 'yellow 'blue)
                   (list 'blue 'green 'purple 'white)
                   (list 'orange 'yellow 'black 'blue)
                   (list 'white 'orange 'orange 'pink)
                   (list 'pink 'red 'red 'black)
                   (list 'yellow 'green 'orange 'blue)
                   (list 'white 'purple 'red 'yellow)
                   (list 'green 'red 'green 'black)
                   (list 'purple 'black 'white 'pink)
                   (list)
                   )
             ))

(define mg1 (make-game 2 3 (list (list 'red)
                                 (list 'yellow 'yellow)
                                 (list 'blue)
                                 (list 'red 'blue))))
(define hg1 (make-game 4 9 (list
                            (list 'pink 'pink 'yellow 'blue)
                            (list 'white 'white 'white 'white)
                            (list 'black 'black 'blue)
                            (list 'orange 'orange 'orange 'pink)
                            (list 'blue 'red 'red 'black)
                            (list 'green 'orange 'blue)
                            (list 'yellow 'yellow 'yellow)
                            (list 'red 'red 'green 'black)
                            (list 'pink)
                            (list 'green 'green 'purple 'purple)
                            (list 'purple 'purple))))
(define hg2 (make-game 4 9 (list
                           (list 'pink 'pink 'yellow 'blue)
                           (list 'white 'white 'white 'white)
                           (list 'black 'black 'blue)
                           (list 'orange 'orange 'orange 'pink)
                           (list 'blue 'red 'red 'black)
                           (list 'green 'orange 'blue)
                           (list 'yellow 'yellow 'yellow)
                           (list 'red 'red 'green 'black)
                           (list)
                           (list 'green 'green 'purple 'purple)
                           (list 'purple 'purple 'pink))))
(define hg3 (make-game 4 9 (list
                           (list 'pink 'pink 'yellow 'blue)
                           (list 'white 'white 'white 'white)
                           (list 'purple 'black 'black 'blue)
                           (list 'orange 'orange 'orange 'pink)
                           (list 'blue 'red 'red 'black)
                           (list 'pink 'green 'orange 'blue)
                           (list 'purple 'yellow 'yellow 'yellow)
                           (list 'red 'red 'green 'black)
                           (list)
                           (list 'green 'green 'purple 'purple)
                           (list))))


(define longgame (make-game 4 15 '((a f g l)
                                   (b e i l)
                                   (b d j j)
                                   (a f i l)
                                   (a e f k)
                                   (m b d f)
                                   (a d e i)
                                   (d g i j)
                                   (b e h k)
                                   (c m g j)
                                   (c g h l)
                                   (c h m k)
                                   (m c h k)
                                   ()
                                   ())))

(define monstergame (make-game 11 13 '((a k g b d a i b c h j)
                                       (k g i d f b c e f h j)
                                       (b b e c f f k e h i j)
                                       (a g f c e d a k h i j)
                                       (a c b a d)
                                       (c d d e f g i g h k k)
                                       (a b e f i g g e h k k)
                                       (a b c d e e f h i j j)
                                       (b a h c d e i f f j j)
                                       (a h g b d e f g i j k)
                                       (d g i j k)
                                       (g b c a h c)
                                       ()
                                       (k d c i h j))))

;;;;;

;; (solve gm draw-option) determines if the game gm is solveable,
;; and will also draw each possible move depending on the draw-option

;; Examples:
;; students should provide some here, or just in tests

;; solve: Game (anyof 'off 'norm 'slow 'fast) -> Bool

;; TUBES BONUS

(define (solve gm draw-option)
  (local
    [(define setup (puzzle-setup gm draw-option))                
     (define (solve-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [else
          (local
            [(define draw (draw-board (first to-visit) draw-option))] 
            (cond
              [(finished-game? (first to-visit)) true]
              [(member? (first to-visit) visited)
               (solve-helper (rest to-visit) visited)]
              [else
               (local [(define nbrs (next-games (first to-visit)))
                       (define new (sort
                         (filter (lambda (x) (and (not (member? x visited))
                                                  (< 0 (blocked x)))) nbrs)
                         optimal?))
                       (define new-to-visit (append new (rest to-visit)))
                       (define new-visited (cons (first to-visit) visited))]
                 (solve-helper new-to-visit new-visited))]))]))]
    (solve-helper (list gm) empty)))



;; game game -> Nat

(define (optimal? x y)
  (local
    [(define nbx (num-blocks x))
     (define nby (num-blocks y))]
  (cond
    [(< nbx nby) true]
    [(> nbx nby) false]
    [(> (blocked x) (blocked y)) true]
    [else false])))

(define (blocked x)
  (foldr + 0 (map (lambda (tb)
                    (cond
                      [(> (los-blocks tb) 1) 0]
                      [else (length tb)])) (game-tubes x))))
    

              
;; Test cases that can be uncommented as the solution is completed

;(check-expect (solve smallgame1 'slow) true)
;(check-expect (solve mediumgamestuck 'slow) false)

;; Below is the format for testing and timing the solution:
;; be sure to remove any other check-expects when measuring your timing

;(check-expect (time (solve mediumgame 'normal)) true)
;(check-expect (time (solve largergame 'normal)) true)
;(check-expect (time (solve biggame 'off)) true)
;(check-expect (time (solve hugegame 'off)) true)

;(check-expect (time (solve mg1 'slow)) true)
;(check-expect (time (solve hg1 'norm)) true)
;(check-expect (time (solve hg2 'norm)) true)
(check-expect (time (solve hg3 'norm)) true)

;(check-expect (time (solve longgame 'off)) true)
;(check-expect (time (solve monstergame 'off)) true)



;; MARCUS L
;; CS 135 FALL 2022
;; ASSIGNMENT 10


;;
;; Part a
;;

;;
;; Part b
;;



(define (pick-clr tubes)
  (cond
    [(empty? tubes) empty]
    [(not (empty? (first tubes))) (first (first tubes))]
    [else (pick-clr (rest tubes))]))



;;
;; Part c
;;


(define (remove-completed gm)
  (local
    [(define new-tubes
       (filter
        (lambda (lst)
          (or (not (equal? lst (filter
                                (lambda (x)
                                  (symbol=? x (first lst))) lst)))
              (not (= (length lst) (game-tubesize gm)))))
        (game-tubes gm)))]
    (make-game (game-tubesize gm)
               (colour-count new-tubes)
               new-tubes)))

(define (colour-count tubes)
  (cond
    [(empty? (pick-clr tubes)) 0]
    [else (add1 (colour-count (map (lambda (tube)
                                     (filter
                                      (lambda (x)
                                        (not (symbol=? (pick-clr tubes) x))) tube))
                                   tubes)))]))




;;
;; Part d
;;

(define (finished-game? gm)
  (cond
    [(empty? (pick-clr (game-tubes (remove-completed gm)))) true]
    [else false]))


;;
;; Part e
;;

(define (num-blocks gm)
  (foldr + 0
         (map (lambda (los)
                (los-blocks los)) (game-tubes gm))))

(define (los-blocks los)
  (cond
    [(empty? los) 0]
    [(= (length los) 1) 1]
    [(symbol=? (first los) (second los)) (los-blocks (rest los))]
    [else (add1 (los-blocks (rest los)))]))

  
;;
;; Part f
;;


;; equiv-game?: Game Game -> Bool

(define (equiv-game? gm1 gm2)
  (cond
    [(not (and (= (game-tubesize gm1) (game-tubesize gm2))
               (= (game-maxcolours gm1) (game-maxcolours gm2)))) false]
    [else
     (local
       [(define tubes1 (game-tubes gm1))
        (define tubes2 (game-tubes gm2))]
       (cond
         [(and (empty? tubes1) (empty? tubes2)) true]
         [else
          (local
            [(define 1sttube (first (game-tubes gm1)))]
            (local
              [(define tubes1removed (remove 1sttube tubes1))
               (define tubes2removed (remove 1sttube tubes2))]
              (cond
                [(not (= (length tubes1) (length tubes2))) false]
                [(= (length tubes1removed) (length tubes2removed))
                 (equiv-game?
                  (make-game (game-tubesize gm1) (game-maxcolours gm1) tubes1removed)
                  (make-game (game-tubesize gm2) (game-maxcolours gm2) tubes2removed))]
                [else false])))]))]))
        

;;
;; Part g
;;


(define (all-equiv? log1 log2)
  (cond
    [(empty? log1)
     (cond
       [(empty? log2) true]
       [else false])]
    [else
     (local
       [(define firstequiv? (lambda (game) (equiv-game? (first log1) game)))
        ;; (remove-game gm log) removes the first instance of an equivalent game
        ;;     to gm from log
        ;; remove-game: Game (listof Game) -> (listof Game)
        (define (remove-game gm log)
          (cond
            [(empty? log) empty]
            [(equiv-game? (first log) gm) (rest log)]
            [else (cons (first log) (remove-game gm (rest log)))]))]
       (cond
         [(ormap firstequiv? log2)
          (all-equiv? (rest log1) (remove-game (first log1) log2))]
         [else false]))]))



;;
;; Part h
;;

(define notempty? (lambda (lst) (not (empty? lst))))

(define (next-games gm)
(filter
   (lambda (gam) (and (notempty? gam) (<= (length (game-tubes (remove-completed gam)))
                                          (length (game-tubes (remove-completed gm))))))
   (foldr append empty
               (build-list (length (game-tubes gm))
                (lambda (n)
                  (local
                    [(define tube (list-ref (game-tubes gm) n))]
                    (cond
                      [(empty? tube) empty]
                      [else 
                       (local
                         [(define ball1 (first tube))]
                         (filter notempty?
                                 (build-list
                                  (length (game-tubes gm))
                                  (lambda (num)
                                    (cond
                                      [(= (length (list-ref (game-tubes gm) num))
                                          (game-tubesize gm)) empty]
                                      [(= num n) empty]
                                      [else (make-game
                                             (game-tubesize gm)
                                             (game-maxcolours gm)
                                             (build-list
                                              (length (game-tubes gm))
                                              (lambda (tuberef)
                                                (cond
                                                  [(= tuberef n)
                                                   (rest tube)]
                                                  [(not (= tuberef num))
                                                   (list-ref
                                                    (game-tubes gm) tuberef)]
                                                  [else (cons
                                                         ball1
                                                         (list-ref
                                                          (game-tubes gm) tuberef))]))))
                                            ])))))])))))))


