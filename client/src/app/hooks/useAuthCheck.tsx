import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { useUser } from "../../../context/context";

function useAuthCheck(redirectIfAuthenticated: string, redirectIfNotAuthenticated: string) {
  const { user } = useUser();
  const router = useRouter();

  useEffect(() => {
    const checkAuthentication = () => {
      // User is not available in the context or doesn't have an ID
      if (!user || !user.id) {
        if (redirectIfNotAuthenticated) {
          router.replace(redirectIfNotAuthenticated);
        }
        return;
      }

      // Check for token in cookies
      const token = document.cookie.split("; ").find((row) => row.startsWith("token="));
      if (!token) {
        if (redirectIfNotAuthenticated) {
          router.replace(redirectIfNotAuthenticated);
        }
        return;
      }

      // If authenticated, redirect as necessary
      if (redirectIfAuthenticated) {
        router.replace(redirectIfAuthenticated);
      }
    };

    checkAuthentication();
  }, [user, router, redirectIfAuthenticated, redirectIfNotAuthenticated]);

  return null; // 状態を返さないのでnullを返す
}

export default useAuthCheck;
