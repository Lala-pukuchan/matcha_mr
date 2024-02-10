import Link from "next/link";

export default function UsersList({ users }) {
  console.log("users: ", users);
  return (
    <div className="flex flex-col m-10 space-y-4">
      {users.map((user) => (
        <div key={user.id} className="grid grid-cols-5">
          <div>
            {user && user.profilePic ? (
              <img
                src={user.profilePic}
                alt="Profile Pic"
                className="h-80 w-80 object-cover rounded"
              />
            ) : (
              <div className="h-80 w-80 bg-gray-200 rounded">No Image</div>
            )}
            <Link href={`/users?userID=${user.id}`}>{user.username}</Link>
          </div>
        </div>
      ))}
    </div>
  );
}
