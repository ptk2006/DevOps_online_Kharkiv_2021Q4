#!/usr/bin/env python
import math
import sys

def main():
    print("Enter coefficients for the equation")
    print("ax^2 + bx + c = 0:")
    a = validate_param("a = ")
    b = validate_param("b = ")
    c = validate_param("c = ")
    square_print (a,b,c)

def validate_param(msg):
    tries = 3
    while tries > 0:
        try:
            return float(input(msg))
        except:
            print("This is not a number")
            tries -= 1
    sys.exit("You could try only 3 times!")

def discriminant(a, b, c):
    return b ** 2 - 4 * a * c

def roots(d, a, b, c):
    if d > 0:
        x1 = (-b + math.sqrt(d)) / (2 * a)
        x2 = (-b - math.sqrt(d)) / (2 * a)
        return x1, x2
    elif d == 0:
        x = -b / (2 * a)
        return x
    else:
        return ('No roots')

def solv_square(a, b, c) -> roots:
    d = discriminant(a, b, c)
    return roots(d, a, b, c)

def square_print(a, b, c):
    x = solv_square(a, b, c)
    print(f"Equation: {a}x^2 + {b}x + {c} = 0")
    print(f"Square equation roots: {x}")

if __name__ == '__main__':
    main()