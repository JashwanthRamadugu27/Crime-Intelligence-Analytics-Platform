import pandas as pd

df = pd.read_csv(
    r"C:\Users\jashw\OneDrive\Documents\KSP DATATHON\Data\KSP_Crime_95K.csv",
    low_memory=False
)

# Top Police Units
top_units = (
    df.groupby("Unit_Name")
      .size()
      .reset_index(name="Total_Crimes")
      .sort_values(by="Total_Crimes", ascending=False)
)

print("\nTop 15 Crime Hotspot Units")
print(top_units.head(15))

top_units.to_csv(
    "crime_hotspot_units.csv",
    index=False
)

# Top Crime Categories
top_crimes = (
    df.groupby("CrimeHead_Name")
      .size()
      .reset_index(name="Total_Cases")
      .sort_values(by="Total_Cases", ascending=False)
)

print("\nTop 15 Crime Categories")
print(top_crimes.head(15))

top_crimes.to_csv(
    "top_crime_categories.csv",
    index=False
)

print("\nFiles Saved:")
print("crime_hotspot_units.csv")
print("top_crime_categories.csv")