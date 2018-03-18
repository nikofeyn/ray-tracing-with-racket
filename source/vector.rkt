#lang racket

; Chapter 2: The vec3 class
; Instead of creating a vec3 class like the book, we create a
; collection of functions that operate on a standard Racket vector.
; 
; These functions are only intended for vectors of numbers,
; although they do not depend on the vector length, i.e., the
; number of components in the vector. There are some improvements
; that can be made. For example, I intend on converting this module
; to use typed racket, forcing the vectors to be composed of numbers.

; Note: This module was developed prior to me finding out about flvectors
; and the additional flvector math operations.
; See: https://docs.racket-lang.org/math/flonum.html#%28part._.Additional_.Flonum_.Vector_.Functions%29
; However, that library only works with flectors, which are a little
; more tedious to construct. For example, (flvector 1 2 3) fails,
; and so you are forced to do something like (flvector 1.0 2.0 3.0).
; Since this module works with regular Racket vectors (will eventually
; be typed to numbers), we can just use #(1 2 3), which is far easier.

(provide (all-defined-out)) ;There are no private functions in this module

(define (square-number x) (* x x))

(define (vector->string v [with-line-feed #f])
  (if with-line-feed
      (add-between (vector->list v) '(" ")#:splice? #t #:after-last '("\n"))
      (add-between (vector->list v) " ")))

(define (sum-vector v)
  (apply + (vector->list v)))

(define (vector+ . vs)
  (apply vector-map + vs))

(define (vector- . vs)
  (apply vector-map - vs))

(define (vector* . vs)
  (apply vector-map * vs))

(define (vector/ . vs)
  (apply vector-map / vs))

(define (vector*c v c)
  (for/vector ([i v]) (* i c)))

(define (vector/c v c)
  (for/vector ([i v]) (/ i c)))

(define (vector-dot-product v1 v2)
  (sum-vector (vector* v1 v2)))

;Currently not implemented
;(define (vector-cross-product v1 v2) #(empty))

(define (vector-norm v)
  (sqrt (sum-vector (vector-map square-number v))))

(define (vector-norm-squared v)
  (square-number (vector-norm v)))

(define (vector-normalize v)
  (vector/c v (vector-norm v)))

(define (vector-exact v)
  (vector-map exact-round v))