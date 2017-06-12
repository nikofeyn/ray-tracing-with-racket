# Ray tracing with Racket

This repository serves as a Racket implementation of the code and ideas found in [Ray Tracing in One Weekend by Peter Shirley](https://www.amazon.com/Ray-Tracing-Weekend-Minibooks-Book-ebook/dp/B01B5AODD8). The code in the book is implemented with C++, and I am using the book as a project guide to write my first Racket programs. [Here is the C++ code repository for the book.](https://github.com/petershirley/raytracinginoneweekend)

Since this is my first Racket project, I have tried, for the most part, to directly port some of the code. But I have been making changes in function names and also the data structures used where it makes sense. For example, the book creates a vector class. I started to do this in Racket but found the approach too heavy. So I switched to using Racket's built-in [vector](http://docs.racket-lang.org/reference/vectors.html) data type. I think the vector operations are actually pretty useful, so I might make a package out of them eventually. I could have chosen to use a row- or column-matrix using Racket's [math/matrix](https://docs.racket-lang.org/math/matrices.html) module but that approach is more verbose since vectors are easier to create.

The code is likely not idiomatic, since I am still learning, so I will hopefully be updating the code as I find better ways to do things.
