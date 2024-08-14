import Link from "next/link";
import Heart from "./heart";
import Geo from "./geo";
import Tag from "./tag";
import MatchRatio from "./matchRatio";
import ReportFakeAccount from "./reportFakeAccount";
import Block from "./block";

export default function UsersList({
  users,
  operationUserId,
  likedUsersId,
  blockedUsersId,
  link,
}) {
  return (
    <div className="flex flex-col m-10 space-y-4">
      <div className="grid md:grid-cols-3 grid-cols-1">
        {users.filter(user => !blockedUsersId.includes(user.id)).map((user) => (
          <div key={user.id} className="grid grid-cols-1 m-1">
            <Link href={`${link}?userID=${user.id}`}>
              {user && user.profilePic ? (
                <img
                  src={user.profilePic}
                  alt="Profile Pic"
                  className="h-80 w-80 object-cover rounded"
                />
              ) : (
                <div className="h-80 w-80 bg-gray-200 rounded">No Image</div>
              )}
              {user.username}({user.age})
            </Link>
            <Heart
              likeFromUserId={operationUserId}
              likeToUserId={user.id}
              alreadyLiked={likedUsersId.includes(user.id)}
            />
            <ReportFakeAccount
              reportedUserId={user.id}
              alreadyReported={user.fake_account}
            />
            <Block  
              blockedFromUserId={operationUserId}
              blockedToUserId={user.id}
            />
            <MatchRatio matchRatio={user.match_ratio} />
            <Geo lat={user.latitude} lon={user.longitude} isRealUser={user.isRealUser} />
            <Tag user={user} />
          </div>
        ))}
      </div>
    </div>
  );
}
