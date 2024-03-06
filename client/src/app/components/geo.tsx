import { useEffect, useState } from "react";

export default function Geo({ lat, lon }) {
  const [country, setCountry] = useState("");
  const [city, setCity] = useState("");

  useEffect(() => {
    if (lat && lon) {
      const url = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lon}&key=${process.env.NEXT_PUBLIC_GOOGLE_API_KEY}`;
      fetch(url)
        .then((response) => response.json())
        .then((data) => {
          try {
            if (data.status === "OK") {
              const addressComponents = data.results[0].address_components;

              const country = addressComponents.find((component) =>
                component.types.includes("country")
              );
              const city = addressComponents.find(
                (component) =>
                  component.types.includes("locality") ||
                  component.types.includes("administrative_area_level_1")
              );
              setCountry(country.long_name);
              setCity(city.long_name);
            } else {
              console.error("No results found");
            }
          } catch (e) {
            //console.error(e
          }
        })
        .catch((error) => console.error("Error:", error));
    }
  }, [lat, lon]);

  return (
    <>
      <div>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="cyan"
          viewBox="0 0 24 24"
          strokeWidth="1.5"
          stroke="currentColor"
          className="w-6 h-6 inline-block"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
          />
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z"
          />
        </svg>
        <p className="inline-block">
          {country} {city}
        </p>
      </div>
    </>
  );
}
