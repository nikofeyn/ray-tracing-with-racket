#lang racket

; Chapter 3: Rays, a simple camera, and background
;
; This module defines the ray struct which is simply an
; ordered pair of vectors (i.e., points) A and B. We define
; functions on the ray to get the beginning, end, and a
; parameterized value that gives us some point that lies on
; the segment defined by the points A and B.

(require "vector.rkt")

(provide (all-defined-out)) ;There are no private functions in this module

(struct ray (A B))

(define (get-origin r) (ray-A r))

(define (get-direction r) (ray-B r))

(define (point-at-parameter r time)
  (vector-sum (ray-A r)
              (vector-multiply-by (ray-B r) time)))