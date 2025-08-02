#!/usr/bin/env python3
"""
Test cases for Woodpecker CI demo application
"""

import pytest
from app import add_numbers, multiply_numbers, divide_numbers, get_user_info


class TestMathFunctions:
    """Mathematical functions test class"""

    def test_add_numbers(self):
        """Test addition function"""
        assert add_numbers(2, 3) == 5
        assert add_numbers(0, 0) == 0
        assert add_numbers(-1, 1) == 0
        assert add_numbers(-5, -3) == -8

    def test_multiply_numbers(self):
        """Test multiplication function"""
        assert multiply_numbers(2, 3) == 6
        assert multiply_numbers(0, 5) == 0
        assert multiply_numbers(-2, 3) == -6
        assert multiply_numbers(-2, -3) == 6

    def test_divide_numbers(self):
        """Test division function"""
        assert divide_numbers(6, 2) == 3.0
        assert divide_numbers(5, 2) == 2.5
        assert divide_numbers(-6, 2) == -3.0

        # Test division by zero exception
        with pytest.raises(ValueError, match="Division by zero is not allowed"):
            divide_numbers(5, 0)


class TestUserInfo:
    """User information test class"""

    def test_get_user_info_valid(self):
        """Test valid user information"""
        user = get_user_info("Alice", 25)
        expected = {"name": "Alice", "age": 25, "is_adult": True, "category": "adult"}
        assert user == expected

    def test_get_user_info_minor(self):
        """Test minor user"""
        user = get_user_info("Bob", 16)
        assert user["is_adult"] is False
        assert user["category"] == "minor"

    def test_get_user_info_invalid_name(self):
        """Test invalid name"""
        with pytest.raises(ValueError, match="Invalid input parameters"):
            get_user_info("", 25)

    def test_get_user_info_invalid_age(self):
        """Test invalid age"""
        with pytest.raises(ValueError, match="Invalid input parameters"):
            get_user_info("Alice", -1)


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
