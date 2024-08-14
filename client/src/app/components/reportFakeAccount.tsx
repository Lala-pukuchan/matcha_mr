import React, { useState, useEffect } from "react";

const ReportFakeAccount = ({ reportedUserId, alreadyReported }) => {
  // update state
  const [isClicked, setIsClicked] = useState(alreadyReported);

  // update reporting status
  useEffect(() => {
    setIsClicked(alreadyReported);
  }, [alreadyReported]);

  const report = () => {
    // update state
    setIsClicked(!isClicked);

    // update report
    async function reportUser() {
      try {
        const json = JSON.stringify({
          id: reportedUserId,
          status: !isClicked,
        });
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/report`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: json,
          }
        );
        console.log("response: ", response);
        if (response.ok) {
          const responseData = await response.json();
          console.log("responseData: ", responseData);
        } else {
          console.error("reporting is failed");
        }
      } catch (e) {
        console.error(e);
      }
    }
    reportUser();
  };

  return (
    <div className="container">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
        strokeWidth="1.5"
        stroke="currentColor"
        className="w-6 h-6 inline-block"
        fill={isClicked ? "yellow" : "none"}
        onClick={report}
        style={{ cursor: "pointer" }}
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z"
        />
      </svg>
      <p className="inline-block">Report As Fake Account</p>
    </div>
  );
};

export default ReportFakeAccount;
