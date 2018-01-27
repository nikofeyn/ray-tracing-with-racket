#lang racket

; Chapter 5: Surface normals and multiple objects
;
; Surface normals for the sphere are implemented to give it
; a basic shaded look.

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
  (build-path images-directory "chapter5-main.ppm"))

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
  (let* ([AC (vector- (get-origin r) center)]
         [a (vector-dot-product (get-direction r) (get-direction r))]
         [b (* 2 (vector-dot-product (get-direction r) AC ))]
         [c (- (vector-dot-product AC AC) (* radius radius))]
         [discriminant (- (* b b) (* 4 a c))])
    (if (< discriminant 0)
        (- 1)
        (/ (- (- b) (sqrt discriminant)) (* 2 a)))))

(define (color r)
  (let ([t1 (hit-sphere #(0 0 -1) 0.5 r)])
    (if (> t1 0)
        (vector*c (vector+ (vector-normalize (vector- (point-at-parameter r t1)
                                                      #(0 0 -1)))
                           #(1 1 1))
                  0.5)
        (let* ([unit-direction (vector-normalize (get-direction r))]
               [t (* 0.5 (+ (vector-ref unit-direction 1) 1))])
          (vector+ (vector*c #(1 1 1) (- 1 t))
                   (vector*c #(0.5 0.7 1) t))))))

(for ([j (in-range (- ny 1) -1 -1)])
  (for ([i (in-range 0 nx 1)])
    (let* ([u (/ i nx)]
           [v (/ j ny)]
           [r (ray origin (vector+ lower-left-corner
                                   (vector*c horizontal u)
                                   (vector*c vertical v)))]
           [col (vector-exact (vector*c (color r) 255))])
      (display-list ppm-file-port (vector->string col #t)))))
    
(close-output-port ppm-file-port)