#lang racket

(struct hit-record (t p normal))

(define hitable%
  (class object%
    (super-new)
    (abstract hit r t-min t-max rec)))

