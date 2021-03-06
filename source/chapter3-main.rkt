#lang racket

; Chapter 3: Rays, a simple camera, and background
;
; This implements a simple camera that looks at a background
; and generates a color based upon the height of the object
; or pixel being viewed. Generates a vertical gradient of blue
; colors from light to dark from bottom to top.

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
  (build-path images-directory "chapter3-main.ppm"))

(unless (directory-exists? images-directory)
  (make-directory images-directory))

(define ppm-file-port (open-output-file ppm-path #:exists 'truncate))

;Displays a list to the ppm-file-port
(define (display-list port l)
  (map (lambda (x) (display x port)) l))

;Write the PPM header for number of columns, rows, and max color
(display-list ppm-file-port (list "P3\n" nx " " ny "\n" 255 "\n"))

(define (color r)
  (let* ([unit-direction (vector-normalize (get-direction r))]
         [t (* 0.5 (+ (vector-ref unit-direction 1) 1))])
    (vector+ (vector*c #(1 1 1) (- 1 t))
             (vector*c #(0.5 0.7 1) t))))

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