import requests
import json

url = "https://stag-api.hireanything.com/user/unified-offerings"
payload = {
    "categoryName": "",
    "subCategoryName": "",
    "date": "",
    "userLocation": None,
    "page": 1,
    "limit": 50,
    "maxDistance": None,
    "sortBy": "relevance"
}

try:
    response = requests.post(url, json=payload)
    response.raise_for_status()
    data = response.json()
    
    if data.get("success"):
        services = data.get("data", [])
        print(f"Total services: {len(services)}")
        
        source_models = set()
        categories = set()
        
        for service in services:
            source_models.add(service.get("sourceModel"))
            cat = service.get("categoryId")
            if cat:
                if isinstance(cat, dict):
                    categories.add(cat.get("categoryName"))
                else:
                    categories.add(str(cat))
                    
        print("Source Models found:", source_models)
        print("Categories found:", categories)
        
        # Check sample service
        if services:
            print("Sample Service:", json.dumps(services[0], indent=2))
            
    else:
        print("API returned success=False")
        print(data)

except Exception as e:
    print(f"Error: {e}")
