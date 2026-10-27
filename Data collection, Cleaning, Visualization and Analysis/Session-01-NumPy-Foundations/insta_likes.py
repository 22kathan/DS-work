"""
SESSION 1: NumPy Foundations (Part 1: Arrays & Creation)
File: insta_likes.py

Topics & Tasks Covered:
1. Importing NumPy as np
2. Instagram Influencer followers array: np.array(), shape, ndim, dtype
3. Zomato 10 consecutive order IDs: np.arange(), size
4. Spotify playlist 'like' identity matrix: np.eye(3) with diagonal explanation
5. Cricket scores list-to-array conversion & memory inspection via .itemsize
"""

# Task 1: Install NumPy in your Python environment using pip, then create a Python file called insta_likes.py and import numpy as np at the top.
import numpy as np


def main():
    print("=" * 70)
    print("SESSION 1: NUMPY FOUNDATIONS - TASKS & EXPLORATIONS")
    print("=" * 70)

    # -------------------------------------------------------------------------
    # Task 2: Create a NumPy array called followers using np.array() that stores
    # the follower counts for 5 Instagram influencers:
    # [1200, 15000, 67000, 340000, 1250000].
    # Print the array, its shape, number of dimensions, and data type.
    # -------------------------------------------------------------------------
    print("\n--- Task 2: Instagram Influencer Followers ---")
    followers = np.array([1200, 15000, 67000, 340000, 1250000])

    print("Followers Array        :", followers)
    print("Array Shape            :", followers.shape)
    print("Number of Dimensions   :", followers.ndim)
    print("Data Type (dtype)      :", followers.dtype)

    # -------------------------------------------------------------------------
    # Task 3: Use np.arange() to generate an array of order IDs for 10
    # consecutive Zomato orders starting from 101. Print the array and its size.
    # -------------------------------------------------------------------------
    print("\n--- Task 3: Zomato Consecutive Order IDs ---")
    # 10 consecutive orders starting from 101 -> 101, 102, ..., 110
    zomato_orders = np.arange(101, 111)

    print("Zomato Order IDs Array :", zomato_orders)
    print("Total Number of Orders :", zomato_orders.size)

    # -------------------------------------------------------------------------
    # Task 4: Create a 3x3 NumPy array using np.eye() to represent a 'like'
    # identity matrix for a new Spotify playlist feature.
    # Print the matrix and explain what the diagonal values represent in a comment.
    # -------------------------------------------------------------------------
    print("\n--- Task 4: Spotify Playlist 'Like' Identity Matrix ---")
    spotify_like_matrix = np.eye(3)

    # COMMENT EXPLANATION:
    # In a Spotify collaborative recommendation or user-track interaction matrix:
    # - The diagonal elements (value 1.0) represent the self-similarity or direct self-affinity
    #   of a playlist/track with itself (i.e., track i compared with track i is a 100% match / self-like).
    # - The off-diagonal elements (value 0.0) represent neutral initial cross-similarity between
    #   distinct items before collaborative filtering weights or user interactions are calculated.
    print("Spotify 'Like' Identity Matrix (3x3):")
    print(spotify_like_matrix)
    print("Diagonal Elements      :", spotify_like_matrix.diagonal())
    print("Explanation: Diagonal values (1.0) represent self-affinity / 100% self-match.")

    # -------------------------------------------------------------------------
    # Task 5: Convert a Python list of cricket scores [45, 67, 120, 89, 54]
    # to a NumPy array, then use the .itemsize attribute to print how many
    # bytes each score takes in memory.
    # -------------------------------------------------------------------------
    print("\n--- Task 5: Cricket Scores List Conversion & Memory Footprint ---")
    cricket_scores_list = [45, 67, 120, 89, 54]
    cricket_scores_array = np.array(cricket_scores_list)

    print("Original Python List   :", cricket_scores_list)
    print("Converted NumPy Array  :", cricket_scores_array)
    print("Array Data Type (dtype):", cricket_scores_array.dtype)
    print("Bytes per item (itemsize):", cricket_scores_array.itemsize, "bytes")
    print("Total array memory     :", cricket_scores_array.nbytes, "bytes")

    # -------------------------------------------------------------------------
    # Bonus Demonstration: Additional Array Creation Methods & Memory Layout
    # (Covering Session 1 Topics: np.linspace, np.zeros, np.ones, np.full, contiguous layout)
    # -------------------------------------------------------------------------
    print("\n--- Additional Session 1 Demonstrations ---")
    print("np.zeros(4)            :", np.zeros(4))
    print("np.ones(4)             :", np.ones(4))
    print("np.full((2, 2), 7)     :\n", np.full((2, 2), 7))
    print("np.linspace(0, 1, 5)   :", np.linspace(0, 1, 5))
    print("Contiguous Memory Check (C_CONTIGUOUS):", cricket_scores_array.flags["C_CONTIGUOUS"])
    print("=" * 70)


if __name__ == "__main__":
    main()
