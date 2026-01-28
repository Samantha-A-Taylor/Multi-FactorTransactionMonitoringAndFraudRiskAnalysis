######### Fraud Flags by Type Pie Chart #########
######################################################
# Flatten the SQL result to counts
flag_counts = list(flags_counts[0])
flag_labels = ['High Value', 'Frequency Spike', 'Login Spike']

# Pie chart with legend instead of slice labels
plt.figure(figsize=(8,8))
wedges, texts, autotexts = plt.pie(
    flag_counts,
    labels=None,  # no labels on slices
    autopct=lambda p: f'{p:.1f}%' if p > 0 else '',  # optional percentages inside slices
    startangle=140,
    colors=[palette[1], palette[0], palette[3]]
)

# Add a legend (key)
plt.legend(wedges, flag_labels, title="Fraud Flag Type", loc="center left", bbox_to_anchor=(1, 0, 0.5, 1))

plt.title("Percentage of Fraud Flags by Type", fontsize=14, fontweight='bold')
plt.show()