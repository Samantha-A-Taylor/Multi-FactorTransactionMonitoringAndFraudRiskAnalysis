######### D #########
########################################################################

# Pivot data for stacked bars
stacked_data = amount_bin_counts.pivot(
    index='TransactionAmountBin', 
    columns='HighValueStatus', 
    values='TransactionCount'
).fillna(0)

# Reorder columns: NORMAL first (bottom), FLAG second (top)
stacked_data = stacked_data[['NORMAL', 'FLAG']]

# Plot
plt.figure(figsize=(15,8))
stacked_data.plot(
    kind='bar', 
    stacked=True, 
    color=[palette[1], palette[3]]  # NORMAL bottom, FLAG top
)
plt.title("Transaction Counts by Amount Bin and High-Value Status (Stacked)", fontsize=14, fontweight='bold')
plt.xlabel("Transaction Amount Range", fontsize=12, fontweight='bold')
plt.ylabel("Number of Transactions", fontsize=12, fontweight='bold')
plt.legend(title="High-Value Status")
plt.xticks(rotation=0)
plt.show()