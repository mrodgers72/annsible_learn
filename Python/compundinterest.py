# Prompt for initial investment, interest rate, and duration
initial_investment = float(input("Enter the initial investment: "))
interest_rate = float(input("Enter the interest rate (in percentage): "))
duration = int(input("Enter the duration (in years): "))

# Convert interest rate to decimal
interest_rate = interest_rate / 100

# Print the values entered
print("Initial Investment:", initial_investment)
print("Interest Rate:", interest_rate)
print("Duration:", duration)

# Calculate the compound interest
compound_interest = initial_investment * (1 + interest_rate) ** duration

# Print the compound interest
print("Compound Interest:", compound_interest)

# prompt for additional investment each year
additional_investment = float(input("Enter the additional investment each year: "))

# calculate the compound interest with additional investment per year
compound_interest = compound_interest + additional_investment * (((1 + interest_rate) ** duration) - 1) / interest_rate

# print the compound interest
print("Compound Interest:", compound_interest)


