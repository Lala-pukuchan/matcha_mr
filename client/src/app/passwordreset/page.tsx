"use client";
import { useState, FormEvent } from "react";

export default function passwordreset() {
  // set message
  const [message, setMessage] = useState("");

  // submit form
  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/resetpassword`,
        {
          method: "POST",
          body: formData,
        }
      );
      if (response.status === 200) {
        window.location.href =
          "/login?message=Please find your new password via email";
      } else {
        const data = await response.json();
        setMessage(data.message);
      }
    } catch (e) {
      console.log(e);
    }
  }

  return (
    <div>
      <form onSubmit={onSubmit} className="container mx-auto w-screen">
        <div className="flex flex-col m-10 space-y-4">
          <label htmlFor="email">email</label>
          <input
            type="email"
            id="email"
            name="email"
            placeholder="email"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <button
            type="submit"
            className="w-40 h-9 rounded bg-pink-400 text-white"
          >
            Reset Pass
          </button>
          <div className="text-red-500">{message}</div>
        </div>
      </form>
    </div>
  );
}
