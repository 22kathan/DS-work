"""
Task 1: playlist_stats.py
Calculates the mean (average) number of daily Spotify song plays.
"""

import statistics

def calculate_mean_plays(plays):
    """
    Takes a list of daily Spotify song play counts and returns the mean.
    """
    if not plays:
        return 0.0
    return sum(plays) / len(plays)

if __name__ == "__main__":
    # Sample daily play counts from Spotify
    daily_plays = [120, 135, 150, 200, 120, 90, 200]
    
    mean_val = calculate_mean_plays(daily_plays)
    
    print("=" * 50)
    print("Spotify Playlist Play Statistics")
    print("=" * 50)
    print(f"Daily Play Counts : {daily_plays}")
    print(f"Total Plays       : {sum(daily_plays)}")
    print(f"Number of Days    : {len(daily_plays)}")
    print(f"Mean Daily Plays  : {mean_val:.2f}")
