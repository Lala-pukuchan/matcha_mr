"use client";
import { useState, useEffect } from "react";
import Image from "next/image";

export default function Home() {
  const [users, setUsers] = useState([]);
  useEffect(() => {
    fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/users`)
      .then((res) => {
        return res.json();
      })
      .then((data) => setUsers(data))
      .catch((err) => console.log(err));
  }, []);
  return (
    <div className="flex justify-center">HOME</div>
  );
}
