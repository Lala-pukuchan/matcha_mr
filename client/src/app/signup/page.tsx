"use client";
import { useState, FormEvent } from "react";
import { validatePassword, validateName } from "../validations/validation";

export default function signup() {
  // set message
  const [message, setMessage] = useState("");

  // submit login form
  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    // prevent default form submission
    event.preventDefault();

    // validate form data and submit
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
      console.log("message: ", message);
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
        window.location.href =
          "/login?message=Please enable your account via email";
      } else {
        const data = await response.json();
        setMessage(data.message);
      }
    } catch (e) {
      console.log("error: ", e);
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
          <label htmlFor="username">username</label>
          <input
            type="username"
            id="username"
            name="username"
            placeholder="username"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <label htmlFor="lastname">lastname</label>
          <input
            type="lastname"
            id="lastname"
            name="lastname"
            placeholder="lastname"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <label htmlFor="firstname">firstname</label>
          <input
            type="firstname"
            id="firstname"
            name="firstname"
            placeholder="firstname"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <label htmlFor="password">password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="password"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <button
            type="submit"
            className="w-40 h-9 rounded bg-pink-400 text-white"
          >
            SignUp
          </button>
          <div className="text-red-500">{message}</div>
        </div>
      </form>
    </div>
  );
}
