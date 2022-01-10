#!/usr/bin/env python
import unittest
import solv_square_equation

class Tests(unittest.TestCase):
    def test_discriminant(self):
        a = 1
        b = -2
        c = -3
        result = solv_square_equation.discriminant(a, b, c)
        self.assertEqual(result, 16)
    def test_roots(self):
        d = 0
        a = 2
        b = 4
        c = 2
        result = solv_square_equation.roots(d, a, b, c)
        self.assertEqual(result, -1)
    def test_solv_squre_1(self):
        a = -1
        b = -2
        c = 15
        result = solv_square_equation.solv_square(a, b, c)
        self.assertEqual(result, (-5, 3))
    def test_solv_squre_2(self):
        a = 2
        b = 4
        c = 8
        result = solv_square_equation.solv_square(a, b, c)
        self.assertEqual(result, 'No roots')
if __name__ == '__main__':
    unittest.main()