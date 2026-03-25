import { withAuth } from "next-auth/middleware";

export default withAuth({
  pages: {
    signIn: "/login",
  },
});

export const config = {
  matcher: [
    "/",
    "/today",
    "/day/:path*",
    "/week",
    "/analytics",
    "/backlog",
    "/categories",
    "/import",
    "/settings",
    "/api/categories/:path*",
    "/api/daily-logs/:path*",
    "/api/task-entries/:path*",
    "/api/backlog-items/:path*",
    "/api/weekly-goals/:path*",
    "/api/analytics/:path*",
    "/api/import/:path*",
    "/api/export/:path*",
  ],
};
