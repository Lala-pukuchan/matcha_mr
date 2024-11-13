import { useState } from "react";
import Slider from "react-slider";

export default function Home() {
  const [ageRange, setAgeRange] = useState([18, 60]);

  return (
    <div className="flex flex-col items-center justify-center p-6">
      <label className="font-bold text-cyan-400">Age Range</label>
      <Slider
        className="w-full h-4 mt-4 bg-gray-200 rounded-lg relative"
        thumbClassName="w-6 h-6 bg-blue-500 rounded-full absolute cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
        trackClassName="bg-gradient-to-r from-blue-400 to-blue-200 h-2 rounded-lg"
        value={ageRange}
        min={18}
        max={100}
        onChange={setAgeRange}
        pearling
        minDistance={1}
        renderThumb={(props, state) => (
          <div {...props} className="w-6 h-6 bg-blue-500 rounded-full">
            {state.valueNow}
          </div>
        )}
      />
      <div className="text-center mt-4">
        Min: {ageRange[0]}, Max: {ageRange[1]}
      </div>
    </div>
  );
}
