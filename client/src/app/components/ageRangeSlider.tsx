import React, { useState } from "react";

function AgeRangeSlider() {
  // State to hold the min and max age values
  const [ageRange, setAgeRange] = useState({ min: 18, max: 60 });

  // Handler for changing slider values
  const handleSliderChange = (e) => {
    const { name, value } = e.target;
    setAgeRange((prevRange) => ({
      ...prevRange,
      [name]: parseInt(value, 10),
    }));
  };

  // Ensure min is not greater than max and vice versa
  const safeMin = Math.min(ageRange.min, ageRange.max);
  const safeMax = Math.max(ageRange.min, ageRange.max);

  return (
    <div className="range-slider">
      <label htmlFor="age" className="text-gray-400">
        Age
      </label>
      <br />
      <input
        type="range"
        id="ageRangeMin"
        name="min"
        min="0"
        max="100"
        value={safeMin}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <input
        type="range"
        id="ageRangeMax"
        name="max"
        min="0"
        max="100"
        value={safeMax}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <div className="range-values text-gray-400 pl-4">
        Age range: {safeMin} - {safeMax}
      </div>
    </div>
  );
}

export default AgeRangeSlider;
