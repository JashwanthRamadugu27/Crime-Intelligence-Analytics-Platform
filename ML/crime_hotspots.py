import pandas as pd

df = pd.read_csv(
    r"C:\Users\jashw\OneDrive\Documents\KSP DATATHON\Data\KSP_Crime_95K.csv",
    low_memory=False
)

severity = (
    df.groupby("Crime_Severity")
      .size()
      .reset_index(name="Total_Cases")
      .sort_values(
          by="Total_Cases",
          ascending=False
      )
)

severity["Percentage"] = (
    severity["Total_Cases"] /
    severity["Total_Cases"].sum() * 100
).round(2)

print("\nCrime Severity Distribution")
print(severity)

severity.to_csv(
    "crime_severity_distribution.csv",
    index=False
)

print("\nFile Saved:")
print("crime_severity_distribution.csv")