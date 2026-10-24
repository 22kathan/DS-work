"""
Task 2: random_sampling_sim.py
Simulates random sampling: selects 50 random users from 1000 fake user IDs.
"""

import random

def simulate_random_sampling(total_users=1000, sample_size=50, seed=42):
    """
    Generates fake user IDs and selects a random sample of specified size.
    """
    if seed is not None:
        random.seed(seed)
        
    population = [f"user{i}" for i in range(1, total_users + 1)]
    sample = random.sample(population, sample_size)
    return population, sample

if __name__ == "__main__":
    pop, sample = simulate_random_sampling(1000, 50, seed=42)
    
    print("=" * 65)
    print("Task 2: Random Sampling Simulation")
    print("=" * 65)
    print(f"Total Population : {len(pop)} users")
    print(f"Sample Size      : {len(sample)} users\n")
    print("Selected User IDs (50 Sampled Users):")
    
    for i in range(0, len(sample), 5):
        row = sample[i:i+5]
        print("  " + "  ".join(f"{u:<11}" for u in row))
        
    print(f"\nUnique Users in Sample: {len(set(sample))} / {len(sample)}")
