######## FraudMetricsWithScores_df Creation ########
########################################################

sql_query = "SELECT * FROM FraudMetricsWithScores"
FraudMetricsWithScores_df = pd.read_sql(sql_query, con=con)
