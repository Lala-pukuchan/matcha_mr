import { useEffect, useState } from "react";

// 座標に対応する国名と都市名のマップを定義
const locations = {
  "48.875312,2.298280": { country: "France", city: "Paris" },
  "51.509897,-0.108740": { country: "UK", city: "London" },
  "52.517251,13.402720": { country: "Germany", city: "Berlin" },
  "21.011485576035128,52.22540600497236": { country: "Poland", city: "Warsaw" },
  "52.225406,21.011486": { country: "Poland", city: "Warsaw" },
  "45.079574,15.063146": { country: "Croatia", city: "Zagreb" },
  "35.689487,139.691706": { country: "Japan", city: "Tokyo" },
  "35.841208,139.829356": { country: "Japan", city: "Tokyo" },
  "35.752097,139.845830": { country: "Japan", city: "Tokyo" },
  "48.885884,2.336185": { country: "France", city: "Paris" },
  "45.764043,4.835659": { country: "France", city: "Lyon" },
  "43.296482,5.369780": { country: "France", city: "Marseille" },
  "43.710173,7.261953": { country: "France", city: "Nice" },
  "48.573405,7.752111": { country: "France", city: "Strasbourg" },
  "44.837789,-0.579180": { country: "France", city: "Bordeaux" },
  "47.218371,-1.553621": { country: "France", city: "Nantes" },
  "50.629250,3.057256": { country: "France", city: "Lille" },
  "43.604652,1.444209": { country: "France", city: "Toulouse" },
  "43.610769,3.876716": { country: "France", city: "Montpellier" },
  "49.443232,1.099971": { country: "France", city: "Rouen" },
  "49.258329,4.031696": { country: "France", city: "Reims" },
  "48.390394,-4.486076": { country: "France", city: "Brest" },
  "49.894067,2.295753": { country: "France", city: "Amiens" },
  "45.777222,3.087025": { country: "France", city: "Clermont-Ferrand" },
  "43.483152,-1.558626": { country: "France", city: "Biarritz" },
  "34.693738,135.502165": { country: "Japan", city: "Osaka" },
  "35.181446,136.906398": { country: "Japan", city: "Nagoya" },
  "43.062096,141.354376": { country: "Japan", city: "Sapporo" },
  "33.590355,130.401716": { country: "Japan", city: "Fukuoka" },
  "38.268215,140.869356": { country: "Japan", city: "Sendai" },
  "34.385203,132.455293": { country: "Japan", city: "Hiroshima" },
  "37.916192,139.036413": { country: "Japan", city: "Niigata" },
  "34.971855,138.388475": { country: "Japan", city: "Hamamatsu" },
  "34.655146,133.919502": { country: "Japan", city: "Okayama" },
  "31.596554,130.557116": { country: "Japan", city: "Kagoshima" },
  "35.443708,139.638026": { country: "Japan", city: "Yokohama" },
  "36.561325,136.656205": { country: "Japan", city: "Kanazawa" },
  "34.690083,135.195511": { country: "Japan", city: "Kobe" },
  "26.212401,127.680932": { country: "Japan", city: "Naha" },
  "35.011636,135.768029": { country: "Japan", city: "Kyoto" },
  "40.712776,-74.005974": { country: "USA", city: "New York" },
  "34.052235,-118.243683": { country: "USA", city: "Los Angeles" },
  "41.878113,-87.629799": { country: "USA", city: "Chicago" },
  "29.760427,-95.369804": { country: "USA", city: "Houston" },
  "33.448377,-112.074037": { country: "USA", city: "Phoenix" },
  "39.952584,-75.165222": { country: "USA", city: "Philadelphia" },
  "29.424122,-98.493629": { country: "USA", city: "San Antonio" },
  "32.715738,-117.161084": { country: "USA", city: "San Diego" },
  "32.776664,-96.796988": { country: "USA", city: "Dallas" },
  "37.338208,-121.886329": { country: "USA", city: "San Jose" },
  "30.267153,-97.743061": { country: "USA", city: "Austin" },
  "30.332184,-81.655651": { country: "USA", city: "Jacksonville" },
  "37.774929,-122.419416": { country: "USA", city: "San Francisco" },
  "39.961176,-82.998794": { country: "USA", city: "Columbus" },
  "35.227087,-80.843127": { country: "USA", city: "Charlotte" },
  "50.850346,4.351721": { country: "Belgium", city: "Brussels" },
  "51.219448,4.402464": { country: "Belgium", city: "Antwerp" },
  "51.054342,3.717424": { country: "Belgium", city: "Ghent" },
  "40.416775,-3.703790": { country: "Spain", city: "Madrid" },
  "41.385064,2.173404": { country: "Spain", city: "Barcelona" },
  "37.389092,-5.984459": { country: "Spain", city: "Seville" },
  "51.506734,-0.113968": { country: "UK", city: "London" },
  "48.885829,2.336149": { country: "France", city: "Paris" },
  "48.885805,2.336175": { country: "France", city: "Paris" },
  "48.896120,2.319370": { country: "France", city: "Paris" }//42Paris
};

export default function Geo({ lat, lon, isRealUser }) {
  const [country, setCountry] = useState("");
  const [city, setCity] = useState("");
  useEffect(() => {
    if (isRealUser && lat && lon) {
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
            console.error(e);
          }
        })
        .catch((error) => console.error("Error:", error));
    } else if (!isRealUser) {
      const locationKey = `${lat},${lon}`;
      const location = locations[locationKey];

      if (location) {
        setCountry(location.country);
        setCity(location.city);
      } else {
        setCountry("Unknown");
        setCity("Unknown");
      }
    }
  }, [lat, lon, isRealUser]);

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
