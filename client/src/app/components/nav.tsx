import Link from "next/link";

export default function Nav() {

  return (
    <nav className="container mx-auto m-6">
      <ul className="flex space-x-4 p-3 text-gray-400">
        <li>
          <Link href="/">Home</Link>
        </li>
        <li>
          <Link href="/searchUser">SearchUser</Link>
        </li>
        <li>
          <Link href="/myAccount">MyAccount</Link>
        </li>
        <li>
          <Link href="/chat">Chat</Link>
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
