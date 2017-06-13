#lang racket

(require "vector.rkt")

; Chapter 2: The vec3 class
; This code re-implements the initial test of creating a PPM file
; using the vector module.
; 
; I am using OpenSeeIt on Windows to view the files.


;Determines the size of the graphic
(define nx 200) ;Number of columns
(define ny 100) ;Number of rows

;Create the PPM file path and images directory
(define images-directory (build-path 'up "images"))

(define ppm-path
  (build-path images-directory "test-vector.ppm"))

(unless (directory-exists? images-directory)
  (make-directory images-directory))

(define ppm-file-port (open-output-file ppm-path #:exists 'truncate))

;Displays a list to the ppm-file-port
(define (display-list l)
  (map (lambda (x) (display x ppm-file-port)) l))

;Write the PPM header for number of columns, rows, and max color
(display-list (list "P3\n" nx " " ny "\n" 255 "\n"))

;A small helper function for calculating color
(define (calculate x y)
  (exact-round (* 255 (/ x y))))

(for ([j (in-range (- ny 1) -1 -1)])
  (for ([i (in-range 0 nx 1)])
    (display-list (vector->string (vector (calculate i nx)
                                          (calculate j ny)
                                          (exact-round (* 255 0.2)))
                                  #t))))
    
(close-output-port ppm-file-port)