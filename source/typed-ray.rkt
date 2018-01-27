#lang typed/racket

(require "vector.rkt")

(define-type Vector3d (Vector Number Number Number))

(struct ray ([A : Vector3d] [B : Vector3d]))

(: get-origin (-> ray Vector3d))
(define (get-origin r) (ray-A r))

(: get-direction (-> ray Vector3d))
(define (get-direction r) (ray-B r))

(: point-at-parameter (-> ray Number Vector3d))
(define (point-at-parameter r time)
  (vector-sum (ray-A r) (vector-multiply-by (ray-B r) time)))