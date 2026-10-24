"""
helper_functions.py
Reusable helper functions for data science project showcase.
Provides modular utility methods for metric calculation, boundary ratios,
performance categorization, and clean reporting.
"""

import pandas as pd
import numpy as np


def calculate_strike_rate(runs: int, balls: int) -> float:
    """Calculate batting strike rate (runs per 100 balls)."""
    if balls <= 0:
        return 0.0
    return round((runs / balls) * 100.0, 2)


def calculate_boundary_percentage(fours: int, sixes: int, runs: int) -> float:
    """Calculate the percentage of total runs scored through boundaries (4s and 6s)."""
    if runs <= 0:
        return 0.0
    boundary_runs = (fours * 4) + (sixes * 6)
    return round((boundary_runs / runs) * 100.0, 2)


def categorize_batsman_impact(runs: int, strike_rate: float) -> str:
    """
    Categorize player impact based on runs scored and scoring velocity.
    - Anchor: High runs, moderate strike rate (<140)
    - Finisher / Power Hitter: High strike rate (>=150)
    - Elite Match Winner: High runs (>=500) and high strike rate (>=145)
    - Accumulator: Standard baseline performance
    """
    if runs >= 500 and strike_rate >= 145.0:
        return "Elite Match Winner"
    elif strike_rate >= 155.0:
        return "Power Hitter"
    elif runs >= 400 and strike_rate < 140.0:
        return "Anchor"
    else:
        return "Accumulator"


def generate_performance_summary(df: pd.DataFrame) -> pd.DataFrame:
    """Compute enriched batting metrics and return a processed summary DataFrame."""
    df_processed = df.copy()
    df_processed["Strike_Rate"] = df_processed.apply(
        lambda r: calculate_strike_rate(r["Runs"], r["Balls_Faced"]), axis=1
    )
    df_processed["Boundary_Pct"] = df_processed.apply(
        lambda r: calculate_boundary_percentage(r["Fours"], r["Sixes"], r["Runs"]), axis=1
    )
    df_processed["Impact_Role"] = df_processed.apply(
        lambda r: categorize_batsman_impact(r["Runs"], r["Strike_Rate"]), axis=1
    )
    return df_processed
