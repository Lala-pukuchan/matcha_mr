export default function Action({ userList, targetUsers }: { userList: any[]; targetUsers: any[] }) {
  return (
    <div>
      <ul>
        {userList.map((user, index) => {
          const isViewed = targetUsers.some(
            (targetUser) => targetUser.from_user_id === user.id
          );
          if (isViewed) {
            return (
              <li key={`${user.id}-${index}`}>
                <p className="pl-2">
                  {user.username} (FullName: {user.firstname} {user.lastname})
                </p>
              </li>
            );
          }
          return null;
        })}
      </ul>
    </div>
  );
}
