#lang racket

; Chapter 2: The vec3 class
; Instead of creating a vec3 class like the book, we create a
; collection of functions that operate on a standard Racket vector.
; 
; These functions are only intended for vectors of numbers,
; although they do not depend on the vector length. There are
; some improvements that can be made. For example, many of the
; operator functions only operate on a pair of vectors. They will
; be extended in the future to accept n-vectors, where n>=1.
; 
; I also intend on converting this module to use typed racket,
; which should force the use of this module for vectors of numbers.


(provide (all-defined-out)) ;There are no private functions in this module

(define (square-number x) (* x x))

(define (vector->string v [with-line-feed #f])
  (if with-line-feed
      (add-between (vector->list v) '(" ")#:splice? #t #:after-last '("\n"))
      (add-between (vector->list v) " ")))

(define (sum-vector v)
  (apply + (vector->list v)))

(define (vector-sum v1 v2)
  (vector-map + v1 v2))

(define (vector-subtract v1 v2)
  (vector-map - v1 v2))

(define (vector-multiply v1 v2)
  (vector-map * v1 v2))

(define (vector-divide v1 v2)
  (vector-map / v1 v2))

(define (vector-multiply-by v c)
  (for/vector ([i v]) (* i c)))

(define (vector-divide-by v c)
  (for/vector ([i v]) (/ i c)))

(define (vector-dot-product v1 v2)
  (sum-vector (vector-multiply v1 v2)))

;Currently not implemented
(define (vector-cross-product v1 v2) #(empty))

(define (vector-norm v)
  (sqrt (sum-vector (vector-map square-number v))))

(define (vector-norm-squared v)
  (square-number (vector-norm v)))

(define (vector-normalize v)
  (vector-divide-by v (vector-norm v)))

(define (vector-exact v)
  (vector-map exact-round v))