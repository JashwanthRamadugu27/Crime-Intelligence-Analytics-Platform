import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

# ----------------------------
# Load Dataset
# ----------------------------

df = pd.read_csv(
    r"C:\Users\jashw\OneDrive\Documents\KSP DATATHON\Data\KSP_Crime_95K.csv",
    low_memory=False
)

# ----------------------------
# Yearly Crime Counts
# ----------------------------

crime_trend = (
    df.groupby("FIR_YEAR")
      .size()
      .reset_index(name="Total_Crimes")
)

crime_trend = crime_trend[crime_trend["FIR_YEAR"] < 2024]

# ----------------------------
# Train Linear Regression Model
# ----------------------------

X = crime_trend[["FIR_YEAR"]]
y = crime_trend["Total_Crimes"]

model = LinearRegression()
model.fit(X, y)

# ----------------------------
# Future Prediction
# ----------------------------

future_years = pd.DataFrame({
    "FIR_YEAR": [2025, 2026, 2027, 2028, 2029, 2030]
})

future_years["Predicted_Crimes"] = (
    model.predict(future_years)
    .round()
    .astype(int)
)

print("\nFuture Crime Forecast")
print(future_years)

future_years.to_csv(
    "crime_forecast_2025_2030.csv",
    index=False
)

# ----------------------------
# Plot Forecast
# ----------------------------

plt.figure(figsize=(12,6), facecolor="white")

# Historical Line
plt.plot(
    crime_trend["FIR_YEAR"],
    crime_trend["Total_Crimes"],
    color="#6D4C8C",
    marker="o",
    markersize=8,
    linewidth=3,
    label="Historical Crimes"
)

# Predicted Line
plt.plot(
    future_years["FIR_YEAR"],
    future_years["Predicted_Crimes"],
    color="#A52A2A",
    marker="o",
    markersize=8,
    linewidth=3,
    linestyle="--",
    label="Predicted Crimes"
)

# Prediction value labels
for x, y in zip(future_years["FIR_YEAR"], future_years["Predicted_Crimes"]):
    plt.text(
        x,
        y + 80,
        f"{y:,}",
        fontsize=9,
        color="#A52A2A",
        ha="center"
    )

# Formatting
plt.title(
    "KSP Crime Forecast (2025–2030)",
    fontsize=18,
    fontweight="bold"
)

plt.xlabel(
    "Year",
    fontsize=13,
    fontweight="bold"
)

plt.ylabel(
    "Total Crime Cases",
    fontsize=13,
    fontweight="bold"
)

plt.xticks(fontsize=11)
plt.yticks(fontsize=11)

plt.grid(
    axis="y",
    linestyle="--",
    alpha=0.35
)

plt.legend(
    fontsize=11,
    loc="upper right"
)

# Remove extra borders
ax = plt.gca()
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

plt.tight_layout()

# Save High Quality Image
plt.savefig(
    "crime_forecast_chart.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()

print("\nFiles Generated Successfully:")
print("1. crime_forecast_2025_2030.csv")
print("2. crime_forecast_chart.png")