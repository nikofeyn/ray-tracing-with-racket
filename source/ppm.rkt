#lang racket

(provide display-list
         create-ppm
         close-ppm)

;Displays a list to the give file port
(define (display-list port l)
  (map (lambda (x) (display x port)) l))

;Creates the needed directories
(define (create-directory-for-file file-path)
  (let ([parent-directory (build-path file-path 'up)])
    (unless (directory-exists? parent-directory)
      (make-directory* parent-directory))))

(define (create-ppm path rows columns max-color)
  (create-directory-for-file path)
  (let ([port (open-output-file path #:exists 'truncate)])
    (display-list port (list "P3\n" columns " " rows "\n" columns "\n"))
    port))

(define (close-ppm port) (close-output-port port))