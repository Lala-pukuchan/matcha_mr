import React, { useState } from "react";

function FameRatingRangeSlider() {
  const [fameRatingRange, setFameRatingRange] = useState({
    fameRatingMin: 0,
    fameRatingMax: 20,
  });

  const handleSliderChange = (e) => {
    const { name, value } = e.target;
    setFameRatingRange(prevRange => {
      const newValue = parseInt(value, 10);
      // Determine if we're adjusting the min or max slider
      if (name === "fameRatingMin" && newValue <= prevRange.fameRatingMax) {
        return { ...prevRange, [name]: newValue };
      } else if (name === "fameRatingMax" && newValue >= prevRange.fameRatingMin) {
        return { ...prevRange, [name]: newValue };
      }
      return prevRange; // Return previous state if new value is out of bounds
    });
  };

  return (
    <div className="range-slider">
      <label htmlFor="fameRating" className="text-gray-400 font-bold">
        FameRating
      </label>
      <br />
      <input
        type="range"
        id="fameRatingRangeMin"
        name="fameRatingMin"
        min="0"
        max="100" // Ensure max attribute allows full range
        value={fameRatingRange.fameRatingMin}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <input
        type="range"
        id="fameRatingRangeMax"
        name="fameRatingMax"
        min="0"
        max="100" // Ensure max attribute allows full range
        value={fameRatingRange.fameRatingMax}
        onChange={handleSliderChange}
        className="w-4/5"
      />
      <div className="range-values text-gray-400 pl-4">
        Matching Ratio range: 
        <br />{fameRatingRange.fameRatingMin} - {fameRatingRange.fameRatingMax} %
      </div>
    </div>
  );
}

export default FameRatingRangeSlider;
