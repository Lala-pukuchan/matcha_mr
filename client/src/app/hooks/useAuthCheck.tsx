import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useUser } from "../../../context/context";

function useAuthCheck(redirectIfAuthenticated: string, redirectIfNotAuthenticated: string) {
  const { user } = useUser();
  const router = useRouter();
  const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null);

  useEffect(() => {
    const checkAuthentication = () => {
      // User is not available in the context or doesn't have an ID
      if (!user || !user.id) {
        if (redirectIfNotAuthenticated) {
          router.push(redirectIfNotAuthenticated);
        }
        setIsAuthenticated(false);
        return;
      }

      // Check for token in cookies
      const token = document.cookie.split("; ").find((row) => row.startsWith("token="));
      if (!token) {
        if (redirectIfNotAuthenticated) {
          router.push(redirectIfNotAuthenticated);
        }
        setIsAuthenticated(false);
        return;
      }

      // If authenticated, redirect as necessary
      setIsAuthenticated(true);
      if (redirectIfAuthenticated) {
        router.push(redirectIfAuthenticated);
      }
    };

    checkAuthentication();
  }, [user, router, redirectIfAuthenticated, redirectIfNotAuthenticated]);

  return isAuthenticated;
}

export default useAuthCheck;
