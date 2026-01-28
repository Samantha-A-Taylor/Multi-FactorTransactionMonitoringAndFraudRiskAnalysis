######### Flagged Transactions Over Time #########
########################################################################

# Ensure TransactionDate is datetime
FraudMetricsWithScores_df['TransactionDate'] = pd.to_datetime(FraudMetricsWithScores_df['TransactionDate'])

# Filter flagged transactions
flagged_df = FraudMetricsWithScores_df[FraudMetricsWithScores_df['MultiFactorScore'] > 0].copy()

# Create YearMonth as period
flagged_df['YearMonth'] = flagged_df['TransactionDate'].dt.to_period('M')

# Create full YearMonth range (all months in dataset)
all_months = pd.period_range(
    start=FraudMetricsWithScores_df['TransactionDate'].min().to_period('M'),
    end=FraudMetricsWithScores_df['TransactionDate'].max().to_period('M'),
    freq='M'
)

# Aggregate flagged counts per month
flagged_agg = flagged_df.groupby('YearMonth').agg(FlaggedTransactions=('TransactionID','count'))

# Reindex to include all months
flagged_agg = flagged_agg.reindex(all_months, fill_value=0).reset_index()
flagged_agg.rename(columns={'index':'YearMonth'}, inplace=True)

# Convert Period back to string for plotting
flagged_agg['YearMonth'] = flagged_agg['YearMonth'].dt.strftime('%Y-%m')

# Plot
plt.figure(figsize=(12,6))
plt.plot(
    flagged_agg['YearMonth'], 
    flagged_agg['FlaggedTransactions'], 
    color='#689C73',
    linewidth=2,
    marker='o',
    markersize=8
)

plt.xlabel("Year-Month", fontsize=12, fontweight='bold')
plt.ylabel("Flagged Transactions", fontsize=12, fontweight='bold')
plt.title("Flagged Transactions Over Time", fontsize=14, fontweight='bold')
plt.grid(False)
plt.tight_layout()
plt.show()