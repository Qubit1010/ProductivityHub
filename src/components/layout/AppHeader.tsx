"use client";

import { usePathname, useRouter } from "next/navigation";
import { CalendarCheck } from "lucide-react";
import { Button } from "@/components/ui/button";
import { SidebarTrigger } from "@/components/ui/sidebar";
import { Separator } from "@/components/ui/separator";
import { DatePicker } from "@/components/shared/DatePicker";
import { ThemeToggle } from "@/components/shared/ThemeToggle";
import { useUIStore } from "@/stores/ui-store";
import { toDateString, getRelativeDay } from "@/lib/utils/date";

const PAGE_TITLES: Record<string, string> = {
  "/": "Dashboard",
  "/today": "Daily Planner",
  "/week": "Weekly View",
  "/analytics": "Analytics",
  "/backlog": "Backlog",
  "/categories": "Categories",
  "/import": "Import",
  "/settings": "Settings",
};

export function AppHeader() {
  const pathname = usePathname();
  const router = useRouter();
  const { selectedDate, setSelectedDate } = useUIStore();

  const isPlannerPage =
    pathname === "/today" || pathname.startsWith("/day/");

  const title = pathname.startsWith("/day/")
    ? "Daily Planner"
    : PAGE_TITLES[pathname] ?? "ProductivityHub";

  const handleDateChange = (date: string) => {
    setSelectedDate(date);
    if (date === toDateString()) {
      router.push("/today");
    } else {
      router.push(`/day/${date}`);
    }
  };

  const goToToday = () => {
    const today = toDateString();
    setSelectedDate(today);
    router.push("/today");
  };

  return (
    <header className="flex h-14 shrink-0 items-center gap-2 border-b px-4">
      <SidebarTrigger className="-ml-1" />
      <Separator orientation="vertical" className="mr-2 h-4" />
      <div className="flex flex-1 items-center justify-between">
        <div className="flex items-center gap-3">
          <h1 className="text-lg font-semibold">{title}</h1>
          {isPlannerPage && (
            <span className="text-sm text-muted-foreground">
              {getRelativeDay(selectedDate)}
            </span>
          )}
        </div>
        <div className="flex items-center gap-2">
          {isPlannerPage && (
            <>
              <DatePicker
                value={selectedDate}
                onChange={handleDateChange}
                className="w-[180px]"
              />
              <Button variant="outline" size="sm" onClick={goToToday}>
                <CalendarCheck className="mr-1 h-4 w-4" />
                Today
              </Button>
            </>
          )}
          <ThemeToggle />
        </div>
      </div>
    </header>
  );
}
