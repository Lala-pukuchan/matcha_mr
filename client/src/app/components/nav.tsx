import Link from "next/link";

export default function Nav() {
  return (
    <nav className="container mx-auto m-3">
      <ul className="flex space-x-4">
        <li>
          <Link href="/">Home</Link>
        </li>
        <li>
          <Link href="/login">Login</Link>
        </li>
        <li>
          <Link href="/logout">Logout</Link>
        </li>
      </ul>
    </nav>
  );
}
