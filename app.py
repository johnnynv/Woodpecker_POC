#!/usr/bin/env python3
"""
Simple Python Web Application Example
Demonstrates various Woodpecker CI features
"""

import json
from typing import Dict, Any


def add_numbers(a: int, b: int) -> int:
    """Addition function"""
    return a + b


def multiply_numbers(a: int, b: int) -> int:
    """Multiplication function"""
    return a * b


def divide_numbers(a: int, b: int) -> float:
    """Division function"""
    if b == 0:
        raise ValueError("Division by zero is not allowed")
    return a / b


def get_user_info(name: str, age: int) -> Dict[str, Any]:
    """Get user information"""
    if not name or age < 0:
        raise ValueError("Invalid input parameters")

    return {
        "name": name,
        "age": age,
        "is_adult": age >= 18,
        "category": "adult" if age >= 18 else "minor",
    }


def main():
    """Main function"""
    print("Woodpecker CI Demo Application")
    print("=" * 40)

    # Test mathematical operations
    print(f"5 + 3 = {add_numbers(5, 3)}")
    print(f"4 * 6 = {multiply_numbers(4, 6)}")
    print(f"10 / 2 = {divide_numbers(10, 2)}")

    # Test user information
    user = get_user_info("Alice", 25)
    print(f"User info: {json.dumps(user, indent=2)}")


if __name__ == "__main__":
    main()
