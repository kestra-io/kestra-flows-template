import json
import os

columns_to_keep_str = os.getenv("COLUMNS_TO_KEEP")
columns_to_keep = json.loads(columns_to_keep_str)

with open("data.json", "r") as file:
    data = json.load(file)

filtered_data = [
    {column: product.get(column, "N/A") for column in columns_to_keep}
    for product in data["products"]
]

with open("products.json", "w") as file:
    json.dump(filtered_data, file, indent=4)
