"use client";
import { useState, FormEvent, useEffect } from "react";
import { validatePassword } from "../validations/validation";

export default function UpdatePassword() {
  const [username, setUsername] = useState<string | null>(null);
  const [message, setMessage] = useState("");
  const [successMessage, setSuccessMessage] = useState("");

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    setUsername(params.get("username"));
  }, []);

  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    setMessage("");
    setSuccessMessage("");
    event.preventDefault(); // Prevent form submission immediately

    const form = event.currentTarget;
    const password = form.password.value;
    const passwordConfirmation = form.passwordConfirmation.value;

    if (password !== passwordConfirmation) {
      setMessage("Passwords do not match");
      return;
    }

    const validations = [
      {
        key: "password",
        validate: () => validatePassword(password),
      },
    ];

    for (const { validate } of validations) {
      const message = validate();
      if (message !== "") {
        setMessage(message);
        return;
      }
    }

    const formData = new FormData(form);
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/auth/updatePassword`,
        {
          method: "POST",
          body: formData,
        }
      );
      const data = await response.json();
      if (response.ok) {
        setSuccessMessage(data.message);
      } else {
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
          <input
            type="hidden"
            name="username"
            value={username || ''}
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
          <input
            type="password"
            id="passwordConfirmation"
            name="passwordConfirmation"
            placeholder="passwordConfirmation"
            required
            className="bg-gray-100 p-3 rounded"
          />
          <button
            type="submit"
            className="w-40 h-9 rounded bg-pink-400 text-white"
          >
            Update Password
          </button>
          <div className="text-red-500">{message}</div>
          <div className="text-green-500">{successMessage}</div>
        </div>
      </form>
    </div>
  );
}
