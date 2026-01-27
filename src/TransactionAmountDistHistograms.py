######## Transaction Amount Distribution Histograms ########
##################################################################

TA_mean = round(bank_transactions_data_df['TransactionAmount'].mean(), 2)
TA_median = round(bank_transactions_data_df['TransactionAmount'].median(), 2)

# Extract labels and counts from SQL result
labels = [row[0] for row in shape_result]
counts = [row[1] for row in shape_result]

# Sort by count descending for skewed view
sorted_pairs = sorted(zip(counts, labels), reverse=True)
sorted_counts, sorted_labels = zip(*sorted_pairs)

# Create vertical subplots (2 rows, 1 column)
fig, axes = plt.subplots(2, 1, figsize=(12,12))

# Histogram 1: original bin order
bars1 = axes[0].bar(labels, counts, color=palette[1])
axes[0].axhline(y=TA_mean, color=palette[3], linestyle='--', label='Mean')
axes[0].axhline(y=TA_median, color=palette[0], linestyle='--', label='Median')
axes[0].set_title("Transaction Amount Distribution Across Dollar Ranges", fontsize=14, fontweight='bold')
axes[0].set_xlabel("Transaction Amount Range", fontsize=12, fontweight='bold')
axes[0].set_ylabel("Number of Transactions", fontsize=12, fontweight='bold')
axes[0].legend()

# Histogram 2: sorted by frequency (true skew)
bars2 = axes[1].bar(sorted_labels, sorted_counts, color=palette[2])
axes[1].axhline(y=TA_mean, color=palette[3], linestyle='--', label='Mean')
axes[1].axhline(y=TA_median, color=palette[0], linestyle='--', label='Median')
axes[1].set_title("Transaction Amounts by Frequency (Highlighting Skew)", fontsize=14, fontweight='bold')
axes[1].set_xlabel("Transaction Amount Range", fontsize=12, fontweight='bold')
axes[1].set_ylabel("Number of Transactions", fontsize=12, fontweight='bold')
axes[1].legend()

# Annotate counts on top of bars
for bar, count in zip(bars1, counts):
    axes[0].text(bar.get_x() + bar.get_width()/2, bar.get_height() + 5, str(count),
                 ha='center', va='bottom', fontsize=10)

# Annotate counts on top of bars
for bar, count in zip(bars2, sorted_counts):
    axes[1].text(bar.get_x() + bar.get_width()/2, bar.get_height() + 5, str(count),
                 ha='center', va='bottom', fontsize=10)

plt.tight_layout()
plt.subplots_adjust(hspace=0.4)  # adjust the vertical space between the two plots
plt.show()