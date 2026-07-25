import pandas as pd

df = pd.read_csv(
    r"C:\Users\jashw\OneDrive\Documents\KSP DATATHON\Data\KSP_Crime_95K.csv",
    low_memory=False
)

district_risk = (
    df.groupby("District_Name")
      .size()
      .reset_index(name="Total_Crimes")
      .sort_values(
          by="Total_Crimes",
          ascending=False
      )
)

print("\nTop 15 High Risk Districts")
print(district_risk.head(15))

district_risk.to_csv(
    "district_risk_ranking.csv",
    index=False
)

print("\nFile Saved:")
print("district_risk_ranking.csv")