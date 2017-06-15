#lang racket

; Chapter 4: Adding a sphere
;
; We implement a hit-sphere function such that the color
; function generates red when a ray hits the sphere.

(require "vector.rkt" "ray.rkt")

;Determines the size of the graphic
(define nx 200) ;Number of columns
(define ny 100) ;Number of rows

;Define some points
(define lower-left-corner #(-2 -1 -1))
(define horizontal #(4 0 0))
(define vertical #(0 2 0))
(define origin #(0 0 0))

;Create the PPM file path and images directory
(define images-directory (build-path 'up "images"))

(define ppm-path
  (build-path images-directory "chapter4-main.ppm"))

(unless (directory-exists? images-directory)
  (make-directory images-directory))

(define ppm-file-port (open-output-file ppm-path #:exists 'truncate))

;Displays a list to the ppm-file-port
(define (display-list port l)
  (map (lambda (x) (display x port)) l))

;Write the PPM header for number of columns, rows, and max color
(display-list ppm-file-port (list "P3\n" nx " " ny "\n" 255 "\n"))

;Checks if the ray r hits the sphere defined by the center vector and radius
(define (hit-sphere center radius r)
  (let* ([AC (vector-subtract (get-origin r) center)]
         [a (vector-dot-product (get-direction r) (get-direction r))]
         [b (* 2 (vector-dot-product (get-direction r) AC ))]
         [c (- (vector-dot-product AC AC) (* radius radius))])
    (> (- (* b b) (* 4 a c)) 0)))

(define (color r)
  (let* ([unit-direction (vector-normalize (get-direction r))]
         [t (* 0.5 (+ (vector-ref unit-direction 1) 1))])
    (if (hit-sphere #(0 0 -1) 0.5 r)
        (vector 1 0 0)
        (vector-sum (vector-multiply-by #(1 1 1) (- 1 t))
                    (vector-multiply-by #(0.5 0.7 1) t)))))

(for ([j (in-range (- ny 1) -1 -1)])
  (for ([i (in-range 0 nx 1)])
    (let* ([u (/ i nx)]
           [v (/ j ny)]
           [r (ray origin (vector-sum lower-left-corner
                                      (vector-sum (vector-multiply-by horizontal u)
                                                  (vector-multiply-by vertical v))))]
           [col (vector-exact (vector-multiply-by (color r) 255))])
      (display-list ppm-file-port (vector->string col #t)))))
    
(close-output-port ppm-file-port)