import React, { useState } from "react";

function AgeRangeSlider() {
  const [ageRange, setAgeRange] = useState({
    ageMin: 0,
    ageMax: 20,
  });

  const handleSliderChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setAgeRange(prevRange => {
      const newValue = parseInt(value, 10);
      // Determine if we're adjusting the min or max slider
      if (name === "ageMin" && newValue <= prevRange.ageMax) {
        return { ...prevRange, [name]: newValue };
      } else if (name === "ageMax" && newValue >= prevRange.ageMin) {
        return { ...prevRange, [name]: newValue };
      }
      return prevRange; // Return previous state if new value is out of bounds
    });
  };

  return (
    <div className="range-slider">
      <label htmlFor="age" className="text-gray-400 font-bold">
        Age
      </label>
      <br />
      <input
        type="range"
        id="ageRangeMin"
        name="ageMin"
        min="0"
        max="100" // Ensure max attribute allows full range
        value={ageRange.ageMin}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <input
        type="range"
        id="ageRangeMax"
        name="ageMax"
        min="0"
        max="100" // Ensure max attribute allows full range
        value={ageRange.ageMax}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <div className="range-values text-gray-400 pl-4">
        Age range: 
        <br />
        {ageRange.ageMin} - {ageRange.ageMax} years old
      </div>
    </div>
  );
}

export default AgeRangeSlider;
