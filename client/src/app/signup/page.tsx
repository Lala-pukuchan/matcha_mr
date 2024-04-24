"use client";
import React, { useState, FormEvent } from "react";
import { validatePassword, validateName } from "../validations/validation";

export default function Signup() {
  const [message, setMessage] = useState("");
  const [selectedGender, setSelectedGender] = useState("");
  const [selectedPreGender, setSelectedPreGender] = useState("");

  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const formData = new FormData(event.currentTarget);
    const validations = [
      {
        key: "password",
        validate: () => validatePassword(formData.get("password") as string),
      },
      {
        key: "firstname",
        validate: () =>
          validateName(formData.get("firstname") as string, "firstname"),
      },
      {
        key: "lastname",
        validate: () =>
          validateName(formData.get("lastname") as string, "lastname"),
      },
      {
        key: "username",
        validate: () =>
          validateName(formData.get("username") as string, "username"),
      },
    ];

    for (const { validate } of validations) {
      const message = validate();
      if (message !== "") {
        setMessage(message);
        return;
      }
    }

    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/createUser`,
        {
          method: "POST",
          body: formData,
        }
      );
      if (response.status === 200) {
        window.location.href = "/login?message=Please enable your account via email";
      } else {
        const data = await response.json();
        setMessage(data.message);
      }
    } catch (e) {
      console.error("error: ", e);
      setMessage("An error occurred. Please try again.");
    }
  }

  return (
    <div className="container mx-auto w-screen">
      <form onSubmit={onSubmit} className="flex flex-col m-10 space-y-4">
        <div>
          <label htmlFor="email">email</label>
          <input
            type="email"
            id="email"
            name="email"
            placeholder="email"
            required
            className="bg-gray-100 p-3 rounded"
          />
        </div>
        <div>
          <label htmlFor="username">username</label>
          <input
            type="username"
            id="username"
            name="username"
            placeholder="username"
            required
            className="bg-gray-100 p-3 rounded"
          />
        </div>
        <div>
          <label htmlFor="lastname">lastname</label>
          <input
            type="lastname"
            id="lastname"
            name="lastname"
            placeholder="lastname"
            required
            className="bg-gray-100 p-3 rounded"
          />
        </div>
        <div>
          <label htmlFor="firstname">firstname</label>
          <input
            type="firstname"
            id="firstname"
            name="firstname"
            placeholder="firstname"
            required
            className="bg-gray-100 p-3 rounded"
          />
        </div>
        <div>
          <label>Gender</label>
          <div>
            <label>
              <input
                type="radio"
                name="gender"
                value="male"
                onChange={() => setSelectedGender("male")}
              /> Male
            </label>
            <label>
              <input
                type="radio"
                name="gender"
                value="female"
                onChange={() => setSelectedGender("female")}
              /> Female
            </label>
          </div>
        </div>
        <div>
          <label>Gender You Like</label>
          <div>
            <label>
              <input
                type="radio"
                name="preference"
                value="male"
                onChange={() => setSelectedPreGender("male")}
              /> Male
            </label>
            <label>
              <input
                type="radio"
                name="preference"
                value="female"
                onChange={() => setSelectedPreGender("female")}
              /> Female
            </label>
            <label>
              <input
                type="radio"
                name="preference"
                value="no"
                onChange={() => setSelectedPreGender("")}
              /> No specific
            </label>
          </div>
        </div>
        <div>
          <label htmlFor="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Password"
            required
            className="bg-gray-100 p-3 rounded"
          />
        </div>
        <button type="submit" className="w-40 h-9 rounded bg-pink-400 text-white">
          Sign Up
        </button>
        <div className="text-red-500">{message}</div>
      </form>
    </div>
  );
}