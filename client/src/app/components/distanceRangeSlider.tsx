import React, { useState } from "react";

function DistanceRangeSlider() {
  const [distanceRange, setDistanceRange] = useState({
    distanceMin: 0,
    distanceMax: 20,
  });

  const handleSliderChange = (e) => {
    const { name, value } = e.target;
    setDistanceRange(prevRange => {
      const newValue = parseInt(value, 10);
      // Determine if we're adjusting the min or max slider
      if (name === "distanceMin" && newValue <= prevRange.distanceMax) {
        return { ...prevRange, [name]: newValue };
      } else if (name === "distanceMax" && newValue >= prevRange.distanceMin) {
        return { ...prevRange, [name]: newValue };
      }
      return prevRange; // Return previous state if new value is out of bounds
    });
  };

  return (
    <div className="range-slider">
      <label htmlFor="distance" className="text-gray-400 font-bold">
        Distance
      </label>
      <br />
      <input
        type="range"
        id="distanceRangeMin"
        name="distanceMin"
        min="0"
        max="100" // Ensure max attribute allows full range
        value={distanceRange.distanceMin}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <input
        type="range"
        id="distanceRangeMax"
        name="distanceMax"
        min="0"
        max="100" // Ensure max attribute allows full range
        value={distanceRange.distanceMax}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <div className="range-values text-gray-400 pl-4">
        Distance range: 
        <br />{distanceRange.distanceMin} - {distanceRange.distanceMax} km
      </div>
    </div>
  );
}

export default DistanceRangeSlider;
