import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useUser } from "../../../context/context";

function useAuthCheck(redirectIfAuthenticated: string, redirectIfNotAuthenticated: string) {
  const { user } = useUser();
  const router = useRouter();
  const [isRedirecting, setIsRedirecting] = useState(false);

  useEffect(() => {
    const checkAuthentication = async () => {
      const token = document.cookie.split("; ").find((row) => row.startsWith("token="));
      if (!token) {
        if (redirectIfNotAuthenticated) {
          setIsRedirecting(true);
          await router.replace(redirectIfNotAuthenticated);
        }
        return;
      }
      if (redirectIfAuthenticated && token) {
        setIsRedirecting(true);
        await router.replace(redirectIfAuthenticated);
      }
    };
    checkAuthentication();
  }, [user, router, redirectIfAuthenticated, redirectIfNotAuthenticated]);
  return isRedirecting;
}

export default useAuthCheck;

